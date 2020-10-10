//
//  FinishAuthorizeResponse.swift
//  mpges.lk
//
//  Created by Timur on 31.08.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct FinishAuthorizeResponse: Decodable, Encodable {
    var terminalKey: String?
    var amount: Int?
    var success: Bool
    var status: String?
    var paymentId: Int?
    var errorCode: String?
    var message: String?
    var details: String?
    var cardId: String?
    var backUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case terminalKey = "terminalKey"
        case amount = "amount"
        case success = "success"
        case status = "status"
        case paymentId = "paymentId"
        case errorCode = "errorCode"
        case message = "message"
        case details = "details"
        case cardId = "cardId"
        case backUrl = "backUrl"
    }
}
