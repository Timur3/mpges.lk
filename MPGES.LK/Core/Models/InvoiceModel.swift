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
    var statusSaldoId: Int
    var statusSaldo: StatusSaldoModel
    var saldo: Double
    var debet: Double
    var credit: Double
    var balanceEndOfPeriod: Double?
    var isClose: Bool
}

public class InvoiceModelVeiw  {
    var year: Int = 0
    var invoices: [InvoiceModel] = []
    
    init(year: Int, invoices: [InvoiceModel])
    {
        self.year = year
        self.invoices = invoices
    }
}

public class InvoiceDetailsModelView {
    var calc: [CalculationModel]
    var pay: [PaymentModel]
    
    init(calc: [CalculationModel], pay: [PaymentModel]) {
        self.calc = calc
        self.pay = pay
    }
}
