//
//  DeviceModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct DeviceModel: Decodable{
    var id: Int
    var deviceNumber: String
    var modelsOfDevice: ModelsOfDevice
    var dateOut: String?
    var dateStateCalibration: String
    var dateNextCalibration: String?
    var addressSet: String
    var deviceAiiscueId: Int?
    var linksOfBuildingToDevices: [LinksOfBuildingToDevicesModel]
    
   enum CodingKeys: String, CodingKey {
       case id = "id"
       case deviceNumber = "deviceNumber"
       case modelsOfDevice = "modelsOfDevice"
       case dateOut = "dateOut"
       case dateStateCalibration = "dateStateCalibration"
       case dateNextCalibration = "dateNextCalibration"
       case addressSet = "addressSet"
       case deviceAiiscueId = "deviceAiiscueId"
       case linksOfBuildingToDevices = "linksOfBuildingToDevices"
   }
}

public struct ModelsOfDevice: Decodable {
    var id: Int
    var marka: String?
    var typeName: String
    var razryad: Int?
    var faza: Int
    var calibrationPeriod: Int
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case marka = "marka"
        case typeName = "typeName"
        case razryad = "razryad"
        case faza = "faza"
        case calibrationPeriod = "calibrationPeriod"
    }
}
