//
//  AuthResultModel.swift
//  mpges.lk
//
//  Created by Timur on 15.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ResponseModel: Decodable {
    var isError: Bool
    var code: Int
    var message: String?
    var data: String?
    var refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case code = "code"
        case message = "message"
        case data = "data"
        case refreshToken = "refreshToken"
     }

}
