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
public struct UserModel: Decodable, Encodable {
    
    let Id: Int
    let Name: String
    let Password: String
    let PasswordHash: String
    let Email: String
    let Mobile: String
    let IsOnline: Bool
    let Confirmed: Bool
    let CreateDate: String
    let RoleId: Int
    
}
