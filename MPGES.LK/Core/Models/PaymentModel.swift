//
//  PaymentModel.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import Foundation
import RealmSwift

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
    @objc var id: Int
    @objc var serviceId: Int
    @objc var registerPaytsId: Int = 0
    @objc var registerOfPayment: RegisterOfPayment?
    @objc var contractId: Int = 0
    @objc var datePay: String = ""
    @objc var summa: Double = 0.00
    @objc var workerId: Int = 0
    @objc var note: String?
    @objc  var uuid: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceId = "serviceId"
        case registerPaytsId = "registerPaytsId"
        case registerOfPayment = "registerOfPayment"
        case contractId = "contractId"
        case datePay = "datePay"
        case summa = "summa"
        case workerId = "workerId"
        case note = "note"
        case uuid = "uuid"
    }
       
    //@objc open override class func primaryKey() -> String? {
     //   return "id"
    //}
    func payYear() -> Int {
        return getYear(dateStr: datePay)
    }
}
