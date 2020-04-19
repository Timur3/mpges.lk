//
//  ContractorModel.swift
//  mpges.lk
//
//  Created by Timur on 01.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
public struct ContractorModel: Decodable {
    var id: Int
    var nameFull: String
    var nameSmall: String
    var dateOfBirth: String

   enum CodingKeys: String, CodingKey {
        case id = "id"
        case nameFull = "nameFull"
        case nameSmall = "nameSmall"
        case dateOfBirth = "dateOfBirth"
   }
}
