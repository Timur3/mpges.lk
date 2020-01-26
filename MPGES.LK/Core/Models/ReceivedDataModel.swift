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
    var data: [ReceivedDataModel]
}

public struct ReceivedDataModel: Decodable {
    var id: Int
    var inspectionId: Int?
    var meteringId: Int?
    var tariffZoneId: Int?
    var tariffZone: String
    var date: String
    var value: Int
    var volume: Int?
    var monthAverage: Int?
    var sredneSut: Decimal?
    var sredneYear: Decimal?
    var meterCircle: Bool
    var koffTrans: Int
    var typeOfReceivedDataId: Int?
    var typeOfReceivedData: String?
    var passedContractor: Bool
}
