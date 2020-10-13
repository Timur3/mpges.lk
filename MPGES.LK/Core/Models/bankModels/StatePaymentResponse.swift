//
//  StateResponse.swift
//  mpges.lk
//
//  Created by Timur on 09.10.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct StatePaymentResponse: Decodable {
    var isError: Bool
    var message: String
    var summa: Decimal
    
    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case message = "message"
        case summa = "summa"
    }
    
    init(isError: Bool, message: String, summa: Decimal) {
        self.isError = isError
        self.message = message
        self.summa = summa
    }
}
