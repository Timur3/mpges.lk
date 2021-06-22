//
//  ReceivedDataAddNewModel.swift
//  mpges.lk
//
//  Created by Timur on 01.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ReceivedDataAddNewModel: Encodable {
    let tariffZoneId: Int
    let date: Date
    let receivedDataValue: Int
}
public struct ReceivedDataAddNewModelList: Encodable {
    let Data:[ReceivedDataAddNewModel]
}
