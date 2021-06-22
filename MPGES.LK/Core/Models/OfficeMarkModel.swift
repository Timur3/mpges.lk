//
//  OfficeMarkModel.swift
//  mpges.lk
//
//  Created by Timur on 27.04.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation

public struct OfficeMarkModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
}
