//
//  SberbankPayModel.swift
//  mpges.lk
//
//  Created by Timur on 26.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct BankPayModel {
    var contractId: Int
    var contractNumber: String
    var emailOrMobile: String
    var summa: String
    
    init(contractId: Int, contractNumber: String, emailOrMobile: String, summa: String) {
        self.contractId = contractId
        self.contractNumber = contractNumber
        self.emailOrMobile = emailOrMobile
        self.summa = summa
    }
}
