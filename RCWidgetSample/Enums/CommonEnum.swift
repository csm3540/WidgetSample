//
//  CommonEnum.swift
//  WidgetSample
//
//  Created by 최성민 on 2021/01/11.
//

import Foundation
import UIKit

enum ServiceCode: String {
    case contract = "CTRTS"
    case diagnosis = "INSDG"
    case claim = "CLAIM"
    
    var pointColor: UIColor {
        switch self {
        case .contract:
            return UIColor(255,172,79)
        case .diagnosis:
            return UIColor(110,178,255)
        case .claim:
            return UIColor(93,211,139)
        }
    }
}
