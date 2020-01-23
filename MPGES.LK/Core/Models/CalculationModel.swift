//
//  CalculationModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct CalculationModelRoot: Decodable {
    var count: Int
    var data: [CalculationModel]
}

public struct CalculationModel: Decodable {
    var id: Int
    
}
