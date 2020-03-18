//
//  ProfileModel.swift
//  mpges.lk
//
//  Created by Timur on 15.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct UserModelRoot: Decodable {
    var count: Int
    var data: [UserModel]
}

public struct UserEmailModel: Encodable {
    var email: String
}

public struct UserModel: Decodable, Encodable {
    
    let Id: Int
    var Name: String
//    let Password: String
//    let PasswordHash: String
    var Email: String
    var Mobile: String
    let IsOnline: Bool
    let Confirmed: Bool
    let CreateDate: String
    let RoleId: Int
    
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Name = "name"
//        case Password = "password"
//        case PasswordHash = "passwordHash"
        case Email = "email"
        case Mobile = "mobile"
        case IsOnline = "isOnline"
        case Confirmed = "confirmed"
        case CreateDate = "createDate"
        case RoleId = "roleId"
    }
    
    init(Id: Int, Name: String,Password: String,PasswordHash: String,Email: String,Mobile: String,IsOnline: Bool,Confirmed: Bool,CreateDate: String, RoleId: Int) {
            self.Id = Id
            self.Name = Name
//            self.Password = Password
//            self.PasswordHash = PasswordHash
            self.Email = Email
            self.Mobile = Mobile
            self.IsOnline = IsOnline
            self.Confirmed = Confirmed
            self.CreateDate = CreateDate
            self.RoleId = RoleId        
       }
}
