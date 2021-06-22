//
//  AuthModel.swift
//  mpges.lk
//
//  Created by Timur on 15.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct SignInModel: Encodable {
    let email: String
    let password: String
    let deviceId: String
}
