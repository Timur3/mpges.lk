//
//  ReceivedDataAddNewTemplateModel.swift
//  mpges.lk
//
//  Created by Timur on 19.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import Foundation

public class ReceivedDataAddNewTemplateModelRoot: Decodable {
    var count: Int
    var data: [ReceivedDataAddNewTemplateModel]
}

public struct ReceivedDataAddNewTemplateModel: Encodable, Decodable {
    let tariffZoneId: Int
    let tariffZone: String
    var meterCircle: Bool
    let previousDate: String
    let previousReceivedData: Int
    var receivedData: Int?
    let tariffValue: Double
    var date: String
    let deviceId: Int
    let razryad: Int
    var isFilled: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case tariffZoneId = "tariffZoneId"
        case tariffZone = "tariffZone"
        case meterCircle = "meterCircle"
        case previousDate = "previousDate"
        case previousReceivedData = "previousReceivedData"
        case receivedData = "receivedData"
        case tariffValue = "tariffValue"
        case date = "date"
        case deviceId = "deviceId"
        case razryad = "razryad"
    }
}

public struct ReceivedDataAddNewTemplateModelView  {
    var date: String
    var receivedDataAddNewTemplates: [ReceivedDataAddNewTemplateModel] = []
}

public struct ReceivedDataOfSendingModel: Encodable, Decodable {
    var date: String
    var tariffZoneId: Int
    var receivedDataValue: Int
}
