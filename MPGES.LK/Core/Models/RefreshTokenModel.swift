//
//  RefreshTokenModel.swift
//  mpges.lk
//
//  Created by Timur on 15.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct RefreshTokenModel: Encodable {
    let refreshToken: String
    let deviceId: String
}
