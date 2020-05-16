//
//  RegisterOfPayment.swift
//  mpges.lk
//
//  Created by Timur on 11.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import RealmSwift

public class RegisterOfPayment: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var date: String
    @objc dynamic var number: String
    @objc dynamic var typeOfPaytId: Int
    var typeOfPayment: TypeOfPayment?
    @objc dynamic var workerId: Int
    @objc dynamic var statusId: Int
    @objc dynamic var note: String?
    @objc dynamic var createBy: String
    @objc dynamic var createDate: String
    @objc dynamic var isDelete: Bool
    @objc dynamic var deleteBy: String?
    @objc dynamic var deleteDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case number = "number"
        case typeOfPaytId = "typeOfPaytId"
        case typeOfPayment = "typeOfPayment"
        case workerId = "workerId"
        case statusId = "statusId"
        case note = "note"
        case createBy = "createBy"
        case createDate = "createDate"
        case isDelete = "isDelete"
        case deleteBy = "deleteBy"
        case deleteDate = "deleteDate"
    }
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
}
