//
//  AddressUnitModel.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct AddressUnit: Decodable {
    var id: Int
    var parentId: Int?
    var addressFull: String?
}
