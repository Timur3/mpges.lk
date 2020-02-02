//
//  InvoiceModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct InvoiceModelRoot: Decodable {
    var count: Int
    var data: [InvoiceModel]
}

public struct InvoiceModel: Decodable {
    var id: Int
    var contractId: Int
    var date: String
    var month: Int
    var year: Int
    var statusSaldoId: Int?
    var statusSaldoName: String
    var saldo: Decimal?
    var debet: Decimal?
    var credit: Decimal?
    var isClose: Bool
}
