//
//  ResponseBankModel.swift
//  mpges.lk
//
//  Created by Timur on 07.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ResponseBankModel: Decodable {
    let success: String
    let data: String?
    let error: ApiError
    
    enum CodingKeys: String, CodingKey {
       case success = ""
       case data = "data"
       case error = "error"
    }
}

public struct ApiError: Decodable {
    let code: Int
    let description: String
    let message: Int
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case description = "description"
        case message = "message"
    }
}

public struct OrderStatus: Decodable {
    let errorCode: Int
    let orderNumber: String
    let orderStatus: Int
    let actionCode: Int
    let actionCodeDescription: String
    let amount: Int
    let currency: Int
    let date: Int
    
}
