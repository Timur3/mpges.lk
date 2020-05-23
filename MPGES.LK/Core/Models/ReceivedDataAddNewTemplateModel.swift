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

public struct ReceivedDataAddNewTemplateModel: Decodable {
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

public class ReceivedDataAddNewTemplateModelView  {
    var date: String
    var tariffZone: String
    var receivedDataAddNewTemplates: [ReceivedDataAddNewTemplateModel] = []
    
    init(date: String, tariffZone: String, receivedDataAddNewTemplates: [ReceivedDataAddNewTemplateModel])
    {
        self.date = date
        self.tariffZone = tariffZone
        self.receivedDataAddNewTemplates = receivedDataAddNewTemplates
    }
}