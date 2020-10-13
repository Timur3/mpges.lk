//
//  ServerResponseModel.swift
//  mpges.lk
//
//  Created by Timur on 22.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public class ServerResponseModel: Decodable {
    var isError: Bool
    var responseCode: Int
    var message: String
    var data: String?
    
    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case responseCode = "responseCode"
        case message = "message"
        case data = "data"
    }
    
    init(isError: Bool, responseCode: Int, message: String, data: String) {
        self.isError = isError
        self.responseCode = responseCode
        self.message = message
        self.data = data
    }
}
