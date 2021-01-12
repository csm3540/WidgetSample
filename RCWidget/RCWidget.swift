//
//  RCWidget.swift
//  RCWidget
//
//  Created by 아이맥 on 2021/01/07.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), widgetDatas: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), widgetDatas: nil)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!    // 1분뒤 새로고침

        NetworkManager.requestWidgetData { result in
            var widgetDatas: [WidgetData] = []
            if let data = result.data {
                let cardList = data.mainCardList.filter {
                    if let _ = ServiceCode(rawValue: $0.serviceCode) {
                        return true
                    } else {
                        return false
                    }
                }
                
                for card in cardList {
                    guard let serviceCode = ServiceCode(rawValue: card.serviceCode) else { return }
                
                    var widgetData: WidgetData = WidgetData(serviceCode: serviceCode)
                    widgetData.category = card.category
                    switch serviceCode {
                    case .contract:
                        let number = NSNumber(value: card.resultInfo.monthInsMoney)
                        let monthInsMoney = Utility.convertCurrency(money: number)
                        
                        widgetData.value = "\(String(card.resultInfo.ctrtCnt)) 건"
                        widgetData.subValue = "월 \(monthInsMoney)원"
                    case .diagnosis:
                        widgetData.value = "\(card.resultInfo.insuranceGrade)등급"
                        widgetData.subValue = card.resultInfo.insuranceCost
                    case .claim:
                        widgetData.value = card.resultInfo.hosDisease
                        widgetData.subValue = card.resultInfo.claimStatusName
                    }
                    widgetDatas.append(widgetData)
                }
            }
            
            entries.append(SimpleEntry(date: entryDate, widgetDatas: widgetDatas))

            let timeline = Timeline(entries: entries, policy: .after(entryDate))
            completion(timeline)
        } failure: { error in
            print(error)
            let timeline = Timeline(entries: entries, policy: .after(entryDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let widgetDatas: [WidgetData]?
}

struct RCWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            if let widgetDatas = entry.widgetDatas {
                ForEach(widgetDatas) { result in
                    let url = URL(string: "widget://pr?url=\("")")!
                    Link(destination: url) {
                        RCWidgetView(widgetData: result)
                    }
                }
            }
        }
    }
}

struct RCWidgetView: View {
    let widgetData: WidgetData
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer().frame(width: 14)
            Text("\(widgetData.category)")
            Text("\(widgetData.value)").foregroundColor(Color(widgetData.serviceCode.pointColor))
            Spacer()
            Text("\(widgetData.subValue)").foregroundColor(Color(widgetData.serviceCode.pointColor))
            Spacer().frame(width: 14)
        }
        Divider()
    }
}

@main
struct RCWidget: Widget {
    let kind: String = "RCWidget"

    // 위젯의 컨텐츠
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            RCWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct RCWidget_Previews: PreviewProvider {
    static var previews: some View {
        RCWidgetEntryView(entry: SimpleEntry(date: Date(), widgetDatas: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
