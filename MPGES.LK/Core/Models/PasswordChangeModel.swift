//
//  PasswordChangeModel.swift
//  mpges.lk
//
//  Created by Timur on 08.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

public struct PasswordChangeModel: Encodable {
    var currentPassword: String
    var newPassword: String
}
