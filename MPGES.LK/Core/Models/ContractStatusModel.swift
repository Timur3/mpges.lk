//
//  ContractStatusModel.swift
//  mpges.lk
//
//  Created by Timur on 22.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//


public struct ContractStatusModel: Decodable {
    let statusName: String
    let value: Double
    let statusId: Int?
}
