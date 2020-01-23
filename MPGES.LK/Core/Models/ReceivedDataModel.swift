//
//  ReceivedDataModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ReceivedDataModelRoot: Decodable {
    var count: Int
    var data: [ReceivedDataModel]?
}

public struct ReceivedDataModel: Decodable {
    var id: Int
    var date: String
    var value: Decimal
    var volume: Int?
    var volumeAvgMonth: Int?
    var createBy: String?
    var createDate: String?
}
