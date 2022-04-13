//
//  ContractStatusModel.swift
//  mpges.lk
//
//  Created by Timur on 22.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public struct ContractStatusModel: Decodable {
    let id: Int
    let statusName: String
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case statusName = "statusName"
        case value = "value"
    }
}
