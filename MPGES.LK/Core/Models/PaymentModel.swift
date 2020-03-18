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
    @objc dynamic var invoiceId: Int
    @objc dynamic var meteringId: Int = 0
    @objc dynamic var registerPaytsId: Int
    @objc dynamic var cash: String
    @objc dynamic var packId: Int = 0
    @objc dynamic var datePay: String
    @objc dynamic var summa: Double = 0.0
    @objc dynamic var workerId: Int
    @objc dynamic var note: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceId = "serviceId"
        case invoiceId = "invoiceId"
        case meteringId = "meteringId"
        case registerPaytsId = "registerPaytsId"
        case cash = "cash"
        case packId = "packId"
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
