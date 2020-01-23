//
//  ContractModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ContractModelRoot: Decodable {
    var count: Int
    var data: [ContractModel]
}

public struct ContractModel: Decodable {
    var id : Int
}
