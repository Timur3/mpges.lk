//
//  ServerResponseModel.swift
//  mpges.lk
//
//  Created by Timur on 22.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ServerResponseModel: Decodable {
    var isError: Bool
    var message: String?
    
    enum CodingKeys: String, CodingKey {
       case isError = "isError"
       case message = "Message"
    }
}
