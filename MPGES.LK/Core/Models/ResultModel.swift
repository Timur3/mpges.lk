//
//  AuthResultModel.swift
//  mpges.lk
//
//  Created by Timur on 15.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ResultModel: Decodable {
    var isError: Bool
    var errorCode: Int
    var errorMessage: String?
    var data: String?
    
    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case errorCode = "errorCode"
        case errorMessage = "errorMessage"
        case data = "data"
     }

}
