//
//  WidgetData.swift
//  WidgetSample
//
//  Created by 최성민 on 2021/01/11.
//

import Foundation

struct WidgetData: Identifiable {
    var serviceCode: ServiceCode
    var category: String
    var value: String
    var subValue: String
    let id = UUID()
    
    init(serviceCode: ServiceCode,
         category: String = "",
         value: String = "",
         subValue: String = "") {
        self.serviceCode = serviceCode
        self.category = category
        self.value = value
        self.subValue = subValue
    }
}
