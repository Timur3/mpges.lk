//
//  DeviceModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct DevicesModelRoot: Decodable {
    var count: Int
    var data: [DeviceModel]
}

public struct DeviceModel: Decodable{
    var id: Int
    var deviceNumber: String
    var deviceTypeName: String
    var dateSet: String?
    var dateRemove: String?
    var dateOut: String?
    var dateStateCalibration: String?
    var dateNextCalibration: String
    var addressSet: String?
    var deviceAiiscueId: Int?
    
   
}

public struct DeviceType: Decodable {
    var id: Int
    var marka: String
    var typeName: String
    var razryad: Int
    var faza: Int
    var calibrationPeriod: Int
}
