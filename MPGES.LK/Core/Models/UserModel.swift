//
//  ProfileModel.swift
//  mpges.lk
//
//  Created by Timur on 15.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct UserEmailModel: Encodable {
    var email: String
}

public struct UserModel: Decodable, Encodable {
    let id: Int
    var name: String
    var email: String
    var mobile: String?
    let isOnline: Bool
    let confirmed: Bool
    let createDate: String
    let roleId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case isOnline = "isOnline"
        case confirmed = "confirmed"
        case createDate = "createDate"
        case roleId = "roleId"
    }
    
    init(Id: Int, Name: String, Password: String, PasswordHash: String, Email: String, Mobile: String, IsOnline: Bool, Confirmed: Bool, CreateDate: String, RoleId: Int) {
        self.id = Id
        self.name = Name
        self.email = Email
        self.mobile = Mobile
        self.isOnline = IsOnline
        self.confirmed = Confirmed
        self.createDate = CreateDate
        self.roleId = RoleId
    }
}
