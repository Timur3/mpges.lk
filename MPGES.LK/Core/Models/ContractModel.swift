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

public struct ContractNumberModel: Encodable {
    var number: String
}

public struct ContractModel: Decodable {
    var id : Int
    var userProfileId: Int
    var codeBinding: String?
    var contractTypeId: Int
    var typeOfContract: TypeOfContractModel
    var number: String
    var dateRegister: String
    var providerId: Int
    var contractorId: Int
    var contractor: ContractorModel
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
    var invoiceDeliveryMethodId: Int
    var invoiceDeliveryMethod: InvoiceDeliveryMethodModel
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

public struct ContractBindingModel: Encodable {
    let number: String
    let code: String
}

public struct ListOfContractNumbersRoot: Decodable {
    let count: Int    
    let data: [String]
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case data = "data"
    }
}
