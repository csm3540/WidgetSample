//
//  Utility.swift
//  RCWidgetSample
//
//  Created by 아이맥 on 2021/01/08.
//

import Foundation

class Utility {
    // 화폐 단위 표시
    static func convertCurrency(money: NSNumber) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: money)!
    }
}
