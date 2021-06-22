//
//  CalculationModel.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct CalculationModel: Decodable {
    var id:                     Int
    var meteringId:             Int
    var buildingId:             Int
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
    var summa:                  Decimal
    var powerObj:               Decimal
    var factorUseValue:         Decimal
    var createBy:               String
    var createDate:             String
    var note:                   String
}
