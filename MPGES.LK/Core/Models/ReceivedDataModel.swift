//
//  ReceivedDataModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import RealmSwift

public class ReceivedDataModelVeiw  {
    var year: Int = 0
    var receivedData: [ReceivedDataModel] = []
    
    init(year: Int, receivedData: [ReceivedDataModel])
    {
        self.year = year
        self.receivedData = receivedData
    }
}

public class ReceivedDataModel: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var meteringId: Int
    @objc dynamic var tariffZoneId: Int
    var tariffZone: TariffZoneModel
    @objc dynamic var date: String
    @objc dynamic var value: Int
    @objc dynamic var volume: Int
    var monthAverage: Double
    @objc dynamic var sredneSut: Double
    @objc dynamic var sredneYear: Double
    @objc dynamic var meterCircle: Bool
    @objc dynamic var koffTrans: Int
    @objc dynamic var typeOfReceivedDataId: Int
    @objc dynamic var typeOfReceivedData: String?
    @objc dynamic var passedContractor: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case meteringId = "meteringId"
        case tariffZoneId = "tariffZoneId"
        case tariffZone = "tariffZone"
        case date = "date"
        case value = "value"
        case volume = "volume"
        case monthAverage = "monthAverage"
        case sredneSut = "sredneSut"
        case sredneYear = "sredneYear"
        case meterCircle = "meterCircle"
        case koffTrans = "koffTrans"
        case typeOfReceivedDataId = "typeOfReceivedDataId"
        case typeOfReceivedData = "typeOfReceivedData"
        case passedContractor = "passedContractor"
    }
       
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    func receivedDataYear() -> Int {
        return getYear(dateStr: date)
    }
}
