//
//  InvoiceModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct InvoiceModel: Decodable {
    let id: Int
    let contractId: Int
    let date: String
    let monthId: Int
    let month: MonthModel?
    var year: Int
    var statusSaldoId: Int
    var statusSaldo: StatusSaldoModel
    var saldo: Double
    var debet: Double
    var debit: Double
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

public struct SendInvoiceModel: Encodable {
    var email: String
    var invoiceId: Int
}
