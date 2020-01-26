//
//  ContractModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ContractModelRoot: Decodable {
    var count: Int
    var data: [ContractModel]
}

public struct ContractModel: Decodable {
    var id : Int
    var userProfileId: Int
    var codeBinding: String?
    var contractTypeId: Int
    var number: String
    var dateRegister: String
    var providerId: Int
    var contractorId: Int
    var contractorNameSmall: String
    var dateStart: String?
    var dateEnd: String?
    var allowSending: Bool
    var note: String?
    var statusId: Int
    var createBy: String?
    var createDate: String
    var jkuId: String?
    var numberEls: String?
    var includedInEpd: Bool
    
    /*enum CodingKeys: String, CodingKey {
        case id = "id"
        case userProfileId = "userProfileId"
        case codeBinding = "codeBinding"
        case contractTypeId = "contractTypeId"
        case number = "number"
        case dateRegister = "dateRegister"
        case providerId = "providerId"
        case contractorId = "contractorId"
        case contractorNameSmall = "contractorNameSmall"
        case workerId = "workerId"
        case note = "note"
    }*/
}
