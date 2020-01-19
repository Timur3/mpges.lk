//
//  PaymentModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct PaymentsModelRoot: Decodable {
    var count: Int
    var data: [PaymentModel]
}

public struct PaymentModel: Decodable {
    var id : Int
    var serviceId: Int?
    var invoiceId: Int?
    var meteringId: Int?
    var registerPaytsId: Int?
    var cash: String?
    var packId: Int
    var datePay: String?
    var summa: Double
    var workerId: Int?
    var note: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceId = "serviceId"
        case invoiceId = "invoiceId"
        case meteringId = "meteringId"
        case registerPaytsId = "registerPaytsId"
        case cash = "cash"
        case packId = "packId"
        case datePay = "datePay"
        case summa = "summa"
        case workerId = "workerId"
        case note = "note"
        
    }
}
