//
//  ApplePayModel.swift
//  mpges.lk
//
//  Created by Timur on 17.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ApplePayModel: Encodable {
    let EncryptedPaymentData: String
    let Amount: Int
    let ContractId: Int
}
