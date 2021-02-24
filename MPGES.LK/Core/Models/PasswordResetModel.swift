//
//  PasswordResetModel.swift
//  mpges.lk
//
//  Created by Timur on 28.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct PasswordResetModel: Encodable {
    var newPassword: String
    var login: String
    var code: String
}
