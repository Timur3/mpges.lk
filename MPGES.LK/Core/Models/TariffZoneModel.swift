//
//  TariffZoneModel.swift
//  mpges.lk
//
//  Created by Timur on 16.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct TariffZoneModel: Decodable {
    var id: Int
    var deviceId: Int
    var typeOfTariffZoneId: Int
    var typeOfTariffZone: TypeOfTariffZoneModel
    var dateStart: String
    var dateEnd: String?
    var isDelete: Bool
    var statusId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deviceId = "deviceId"
        case typeOfTariffZoneId = "typeOfTariffZoneId"
        case typeOfTariffZone = "typeOfTariffZone"
        case dateStart = "dateStart"
        case dateEnd = "dateEnd"
        case isDelete = "isDelete"
        case statusId = "statusId"
    }
}
