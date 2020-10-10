//
//  StateResponse.swift
//  mpges.lk
//
//  Created by Timur on 09.10.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct StateResponse: Decodable {
    var terminalKey: String?
    var orderId: String?
    var success: Bool
    var status: String?
    var paymentId: Int?
    var errorCode: String?
    var message: String?
    var details: String?
    
    enum CodingKeys: String, CodingKey {
        case terminalKey = "terminalKey"
        case orderId = "orderId"
        case success = "success"
        case status = "status"
        case paymentId = "paymentId"
        case errorCode = "errorCode"
        case message = "message"
        case details = "details"
    }
}
