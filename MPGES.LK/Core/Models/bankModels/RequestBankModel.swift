//
//  RequestBankModel.swift
//  mpges.lk
//
//  Created by Timur on 07.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct RequestBankModel: Encodable {
    let merchant: String
    let orderNumber: String
    let description: String
    let language: String
    let additionParameters: [AdditionParameter]
    let preAuth: String
    let paymentToken: String
}

public struct AdditionParameter: Encodable {
    let accountNumber: String
}

