//
//  DevileryOfInvoiceModel.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct InvoiceDeliveryMethodModelRoot: Decodable {
    var count: Int
    var data: [InvoiceDeliveryMethodModel]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case data = "data"
    }
    
    init(count: Int, data: [InvoiceDeliveryMethodModel]) {
        self.count = count
        self.data = data
    }
}

public struct InvoiceDeliveryMethodModel: Decodable{
    var id: Int
    var devileryMethodName: String
    var selected: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case devileryMethodName = "devileryMethodName"
        case selected = "selected"
    }
    init(id: Int, devileryMethodName: String, selected: Bool) {
        self.id = id
        self.devileryMethodName = devileryMethodName
        self.selected = selected
    }
    
}
