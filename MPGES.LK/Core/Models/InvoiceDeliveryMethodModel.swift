//
//  DevileryOfInvoiceModel.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct InvoiceDeliveryMethodModel: Decodable{
    var id: Int
    var devileryMethodName: String
    var selected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case devileryMethodName = "devileryMethodName"
    }
    init(id: Int, devileryMethodName: String, selected: Bool) {
        self.id = id
        self.devileryMethodName = devileryMethodName
    }
    
}
