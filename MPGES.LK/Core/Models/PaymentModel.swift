//
//  PaymentModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import RealmSwift

public class PaymentsModelRoot: Object, Decodable {
    var count: Int
    var data: [PaymentModel]
}

public class PaymentsModelVeiw  {
    var year: Int = 0
    var payments: [PaymentModel] = []
    
    init(year: Int, payments: [PaymentModel])
    {
        self.year = year
        self.payments = payments
    }
}

public class PaymentModel: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var serviceId: Int
    var invoiceId: Int?
    @objc dynamic var registerPaytsId: Int = 0
    var registerOfPayment: RegisterOfPayment?
    @objc dynamic var contractId: Int = 0
    @objc dynamic var datePay: String = ""
    @objc dynamic var summa: Double = 0.0
    @objc dynamic var workerId: Int = 0
    var note: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceId = "serviceId"
        case invoiceId = "invoiceId"
        case registerPaytsId = "registerPaytsId"
        case registerOfPayment = "registerOfPayment"
        case contractId = "contractId"
        case datePay = "datePay"
        case summa = "summa"
        case workerId = "workerId"
        case note = "note"
    }
       
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    func payYear() -> Int {
        return getYear(dateStr: datePay)
    }
}
