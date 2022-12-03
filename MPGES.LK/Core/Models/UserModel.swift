//
//  ProfileModel.swift
//  mpges.lk
//
//  Created by Timur on 15.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

struct EmailModel: Encodable {
    var email: String
}

struct UserModel: Decodable, Encodable {
    let id: Int
    var name: String
    var email: String
    var mobile: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
    }
    
    init(id: Int, name: String, email: String, mobile: String) {
        self.id = id
        self.name = name
        self.email = email
        self.mobile = mobile
    }
}
