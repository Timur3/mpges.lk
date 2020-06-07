//
//  UserDataProtocol.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol UserDataProtocol {
    
    func setKey(keyName: String, keyValue: String)
    func getKey(keyName: String) -> String?
    
    func setToken(token: String)
    func getToken() -> String?
    
    func setCurrentContract(contract: ContractModel)
    func getCurrentContract() -> Int?
    
    func setCurrentInvoice(invoice: InvoiceModel)
    func getCurrentInvoice() -> Int?
    
    func delData()
    
}
