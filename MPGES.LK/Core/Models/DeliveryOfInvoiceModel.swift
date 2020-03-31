//
//  DevileryOfInvoiceModel.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct DeliveryOfInvoiceModelRoot: Decodable {
    var count: Int
    var data: [DeliveryOfInvoiceModel]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case data = "data"
    }
    
    init(count: Int, data: [DeliveryOfInvoiceModel]) {
        self.count = count
        self.data = data
    }
}

public struct DeliveryOfInvoiceModel: Decodable{
    var id: Int
    var devileryMethodName: String
    var selected: Bool

   enum CodingKeys: String, CodingKey {
        case id = "id"
        case devileryMethodName = "devileryMethodName"
        case selected = "selected"
   }
}
