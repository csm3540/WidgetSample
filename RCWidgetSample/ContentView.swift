//
//  ContentView.swift
//  RCWidgetSample
//
//  Created by 아이맥 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = "test"
    @State private var showingAlert = false
   // @State private var widgetData: WidgetData
    var body: some View {
        Text(text)
            .padding()
            .onAppear {
            }
            .onOpenURL(perform: { url in
                self.showingAlert = true
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
            }
            
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
