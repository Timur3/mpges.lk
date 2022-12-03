//
//  CalculationModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ReceivedDataVolumeModel: Decodable {
    var date: String
    var unixDate: Int
    var volume: Int
}
