//
//  APIBaseData.swift
//  WidgetSample
//
//  Created by 최성민 on 2021/01/11.
//

import Foundation

class GRAPIBaseData: Codable {
    var message: String
    var responseCode: Int
    
    private enum CodingKeys: String, CodingKey {
        case message, responseCode, data
    }
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        message         = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        responseCode    = try container.decodeIfPresent(Int.self, forKey: .responseCode) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(responseCode, forKey: .responseCode)
    }
}

class GRAPIGenericBaseData<T: GRAPIDataBaseData>: GRAPIBaseData {
    var data: T?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        data            = try container.decodeIfPresent(T.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
    }
}

class GRAPIDataBaseData: Codable {
    var result: String
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case result, message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        result = try container.decodeIfPresent(String.self, forKey: .result) ?? ""
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    init(result: String = "", message: String = "") {
        self.result = result
        self.message = message
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(result, forKey: .result)
        try container.encode(message, forKey: .message)
    }
}
