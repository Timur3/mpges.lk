//
//  ContractStatusModel.swift
//  mpges.lk
//
//  Created by Timur on 22.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public struct ContractStatusModel: Decodable {
    let statusName: String
    let value: Decimal
    
    enum CodingKeys: String, CodingKey {
        case statusName = "statusName"
        case value = "value"
    }
}
