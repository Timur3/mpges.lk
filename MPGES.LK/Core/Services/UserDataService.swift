//
//  UserDataService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation


public class UserDataService: UserDataProtocol {

    func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func getToken() -> String? {
           return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func setCurrentContract(contract: ContractModel) {
        UserDefaults.standard.set(contract.id, forKey: "currentContract")
    }
    
    func getCurrentContract() -> Int? {
       return UserDefaults.standard.integer(forKey: "currentContract")
    }
    
    func setCurrentInvoice(invoice: InvoiceModel) {
        UserDefaults.standard.set(invoice, forKey: "currentInvoice")
    }
    
    func getCurrentInvoice() -> InvoiceModel? {
        return UserDefaults.standard.object(forKey: "currentInvoice") as? InvoiceModel
    }
    
    func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "currentContract")
        UserDefaults.standard.set("", forKey: "currentInvoice")
    }
}
