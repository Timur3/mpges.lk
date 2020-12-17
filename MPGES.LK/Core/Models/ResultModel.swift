//
//  ResultModel.swift
//  mpges.lk
//
//  Created by Timur on 11.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public class ResultModel<T: Decodable>: Decodable {
    var isError: Bool
    var code: Int
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case code = "code"
        case message = "message"
        case data = "data"
    }
    
    init(isError: Bool, code: Int, message: String, data: T) {
        self.isError = isError
        self.code = code
        self.message = message
        self.data = data
    }
}
