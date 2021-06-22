//
//  UserDataProtocol.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol UserDataProtocol {
    
    func setKey<T>(keyName: String, keyValue: T)
    //func getKey<T>(keyName: String) -> T?
    func getKey(keyName: String) -> String?
    
    func setToken(token: String)
    func getToken() -> String?
    func delToken()
    
    func setCurrentContract(contract: ContractModel)
    func getCurrentContract() -> Int?
    
    func setCurrentInvoice(invoice: InvoiceModel)
    func getCurrentInvoice() -> Int?
    
    func delData()
    
}
