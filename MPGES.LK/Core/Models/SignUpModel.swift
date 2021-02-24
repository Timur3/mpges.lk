//
//  SignUpModel.swift
//  mpges.lk
//
//  Created by Timur on 08.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct SingUpModel: Encodable {
    let id: Int
    let password: String
    let name: String
    let email: String
    let mobile: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case password = "password"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
    }
    
    init(name: String, password: String, email: String, mobile: String) {
        self.id = 0
        self.password = password
        self.name = name
        self.email = email
        self.mobile = mobile
    }
}
