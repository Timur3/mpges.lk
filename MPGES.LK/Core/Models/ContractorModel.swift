//
//  ContractorModel.swift
//  mpges.lk
//
//  Created by Timur on 01.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
public struct ContractorModel: Decodable {
    var id: Int
    var family: String
    var name: String
    var middleName: String?
    var nameSmall: String
    var dateOfBirth: String
    var passportSeria: String
    var typeOfContractorId: Int
    var typeOfContractor: TypeOfContractorModel
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case family = "family"
        case name = "name"
        case middleName = "middleName"
        case nameSmall = "nameSmall"
        case dateOfBirth = "dateOfBirth"
        case passportSeria = "passportSeria"
        case typeOfContractorId = "typeOfContractorId"
        case typeOfContractor = "typeOfContractor"
    }
    
/*    init(id: Int, family:)
    {
        self.year = year
        self.payments = payments
    }*/
}

public struct TypeOfContractorModel: Decodable {
    var id: Int
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
