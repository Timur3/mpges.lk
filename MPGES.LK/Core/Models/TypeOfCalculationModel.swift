//
//  TypeOfCalculation.swift
//  mpges.lk
//
//  Created by Timur on 15.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct TypeOfCalculationModel: Decodable {
    var id: Int
    var name: String

   enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
   }
}
