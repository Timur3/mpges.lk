//
//  SignUpModel.swift
//  mpges.lk
//
//  Created by Timur on 08.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct SingUpModel: Encodable {
    let password: String
    let name: String
    let email: String
    let mobile: String?
    let roleId: Int
    
    enum CodingKeys: String, CodingKey {
        case password = "password"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case roleId = "roleId"
    }
    
    init(name: String, password: String, Email: String, Mobile: String, RoleId: Int) {
        self.password = password
        self.name = name
        self.email = Email
        self.mobile = Mobile
        self.roleId = RoleId
    }
}
