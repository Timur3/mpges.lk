//
//  TypeOfTariffZoneModel.swift
//  mpges.lk
//
//  Created by Timur on 01.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct TypeOfTariffZoneModel: Decodable {
    var id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

