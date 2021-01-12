//
//  RCWidgetSampleApp.swift
//  RCWidgetSample
//
//  Created by 아이맥 on 2021/01/07.
//

import SwiftUI

@main
struct RCWidgetSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // handle the URL that must be opened
                    print("============================")
                    print(url)
                }
        }
    }
}
