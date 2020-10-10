//
//  CalculationModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ReceivedDataVolumeModelRoot: Decodable {
    var count:  Int
    var data:   [ReceivedDataVolumeModel]
}

public struct ReceivedDataVolumeModel: Decodable {
    var volume: Double
    var date:   String
}
