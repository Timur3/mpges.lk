//
//  TypeOfPayment.swift
//  mpges.lk
//
//  Created by Timur on 11.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import Foundation
import RealmSwift

public class TypeOfPayment: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
}
