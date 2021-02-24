//
//  UserDataService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation


public class UserDataService: UserDataProtocol {
    
    func setKey<T>(keyName: String, keyValue: T) {
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    func delToken() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "refreshToken")
        UserDefaults.standard.set(false, forKey: "isAuth")
    }
    
    static let shared = UserDataService()
    
    func getKey(keyName: String) -> String? {
        return UserDefaults.standard.string(forKey: keyName)
    }
    
    func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func getToken() -> String? {
           return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    
    func setRefreshToken(token: String) {
        UserDefaults.standard.set(token, forKey: "refreshToken")
    }
    
    func getRefreshToken() -> String? {
           return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    func setCurrentContract(contract: ContractModel) {
        UserDefaults.standard.set(contract.id, forKey: "currentContract")
    }
    
    func getCurrentContract() -> Int? {
       return UserDefaults.standard.integer(forKey: "currentContract")
    }
    
    func setCurrentInvoice(invoice: InvoiceModel) {
        UserDefaults.standard.set(invoice.id, forKey: "currentInvoice")
    }
    
    func getCurrentInvoice() -> Int? {
        return UserDefaults.standard.integer(forKey: "currentInvoice")
    }
    
    func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "currentContract")
        UserDefaults.standard.set("", forKey: "currentInvoice")
        UserDefaults.standard.set("", forKey: "refreshToken")
    }
    
    func setIsAuth(){
        UserDefaults.standard.set(true, forKey: "isAuth")
    }
}
