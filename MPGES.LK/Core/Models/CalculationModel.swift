//
//  CalculationModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct CalculationModelRoot: Decodable {
    var count: Int
    var data: [CalculationModel]
}

public struct CalculationModel: Decodable {
    var id:                     Int
    var meteringId:             Int
    var objectId:               Int
    var invoiceId:              Int
    var zoneId:                 Int
    var tariffZone:             TariffZoneModel
    var shkId:                  Int
    var typeOfCalculationId:    Int
    var typeOfCalculation:      TypeOfCalculationModel
    var date:                   String
    var monthId:                Int
    var year:                   Int
    var tarifValueId:           Int
    var receivedDataId:         Int
    var testi:                  Int
    var pTesti:                 Int
    var volume:                 Int
    var summa:                  Double
    var powerObj:               Double
    var factorUseValue:         Double
    var createBy:               String
    var createDate:             String
    var note:                   String
}
