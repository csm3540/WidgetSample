//
//  DraWerInfoData.swift
//  WidgetSample
//
//  Created by 최성민 on 2021/01/11.
//

import Foundation

typealias DraWerInfoData = GRAPIGenericBaseData<DraWerInfoResponseData>

// 상담 현황 상세 정보
class DraWerInfoResponseData: GRAPIDataBaseData {
    var mainCardList: [DraWerCardData]

    private enum CodingKeys: String, CodingKey {
        case mainCardList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        mainCardList = try container.decodeIfPresent([DraWerCardData].self, forKey: .mainCardList) ?? [DraWerCardData]()
        
        try super.init(from: decoder)
    }
}

class DraWerCardData: Decodable {
    var serviceCode: String = ""    // 서비스 코드
    //    var status: ServiceStatus = .none       // 서비스 상태
    var category: String = ""               // 서비스 명칭
    var resultYn: String?                   // 결과 화면 노출 여부 (미확인)
    var resultInfo: DraWerCardResultData = DraWerCardResultData()   // 서비스 결과
    
    private enum CodingKeys: String, CodingKey {
        case serviceCode, category, title, message, status, resultYn, resultInfo, subList
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        serviceCode = try container.decodeIfPresent(String.self, forKey: .serviceCode) ?? ""
        //        status = ServiceStatus(rawValue: try container.decodeIfPresent(String.self, forKey: .status) ?? "N") ?? .none
        category =  try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        resultYn =  try container.decodeIfPresent(String.self, forKey: .resultYn)
        resultInfo =  try container.decodeIfPresent(DraWerCardResultData.self, forKey: .resultInfo) ?? DraWerCardResultData()
    }
}

class DraWerCardResultData: Decodable {
    // 1. 내 보험
    var ctrtCnt: Int = 0        // 내 보험 건수
    var monthInsMoney: Int = 0  // 월 보험료
    
    // 2. 보험분석
    var insuranceGrade: String = "" // 보험등급
    var insuranceIndex: Int = 0     // 보험지수
    var insuranceCost: String = ""  // 보험가성비
    
    // 6. 보험금 청구"
    var claimSeq: Int = 0               // 청구 Seq
    var hosDisease: String = ""         // 청구명 (진단 명칭)"
    var claimStatusName: String = ""    // 청구 진행 상태
    var completeClaimDt: String = ""    // 청구일 (신청 완료일)
    var claimStatus: String = ""        // 청구상태
    
    private enum CodingKeys: String, CodingKey {
        case ctrtCnt, monthInsMoney
        case insuranceGrade, insuranceIndex, insuranceCost
        case claimSeq, hosDisease, claimStatusName, completeClaimDt, claimStatus
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        ctrtCnt = try container.decodeIfPresent(Int.self, forKey: .ctrtCnt) ?? 0
        monthInsMoney =  try container.decodeIfPresent(Int.self, forKey: .monthInsMoney) ?? 0
        
        insuranceGrade =  try container.decodeIfPresent(String.self, forKey: .insuranceGrade) ?? ""
        insuranceIndex =  try container.decodeIfPresent(Int.self, forKey: .insuranceIndex) ?? 0
        insuranceCost =  try container.decodeIfPresent(String.self, forKey: .insuranceCost) ?? ""
        
        claimSeq =  try container.decodeIfPresent(Int.self, forKey: .claimSeq) ?? 0
        hosDisease =  try container.decodeIfPresent(String.self, forKey: .hosDisease) ?? ""
        claimStatusName =  try container.decodeIfPresent(String.self, forKey: .claimStatusName) ?? ""
        completeClaimDt =  try container.decodeIfPresent(String.self, forKey: .completeClaimDt) ?? ""
        claimStatus =  try container.decodeIfPresent(String.self, forKey: .claimStatus) ?? ""
    }
}
