//
//  NetworkManager.swift
//  WidgetSample
//
//  Created by 최성민 on 2021/01/11.
//

import Foundation
import Alamofire

class NetworkManager {
    // 위젯 정보 요청
    static func requestWidgetData(serviceDt: String? = nil,
                                  success: @escaping (_ result: DraWerInfoData) -> (),
                                  failure: @escaping (_ error: Error) -> ()) {
        
        let url = ""
        let params: Parameters = [:]
        let headers: HTTPHeaders = ["": ""]
        AF.request(url, method: .get,
                   parameters: params,
                   headers: headers)
            .responseData { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(DraWerInfoData.self, from: data)
                        
                        success(result)
                    } catch {
                        failure(error)
                    }
                case .failure(let error):
                    failure(error)
                }
            }
    }
}
