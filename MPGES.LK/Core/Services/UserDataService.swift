//
//  UserDataService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation


public class UserDataService: UserDataProtocol {
        
    static let shared = UserDataService()
    
    func setKey<T>(keyName: String, keyValue: T) {
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    func getKey(keyName: String) -> String? {
        return UserDefaults.standard.string(forKey: keyName)
    }
    
    func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: "email")
    }
    
    func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func getToken() -> String? {
           return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func setRefreshToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "refreshToken")
    }
    
    func getRefreshToken() -> String? {
           return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    func setCurrentContract(_ contract: ContractModel) {
        UserDefaults.standard.set(contract.id, forKey: "currentContract")
    }
    
    func getCurrentContract() -> Int? {
       return UserDefaults.standard.integer(forKey: "currentContract")
    }
    
    func setCurrentInvoice(_ invoice: InvoiceModel) {
        UserDefaults.standard.set(invoice.id, forKey: "currentInvoice")
    }
    
    func getCurrentInvoice() -> Int? {
        return UserDefaults.standard.integer(forKey: "currentInvoice")
    }
    
    
    func delToken() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "refreshToken")
        UserDefaults.standard.set(false, forKey: "isAuth")
    }
    
    func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "currentContract")
        UserDefaults.standard.set("", forKey: "currentInvoice")
        UserDefaults.standard.set("", forKey: "refreshToken")
    }
    
    func setIsAuth(){
        debugPrint("true is Auth")
        UserDefaults.standard.set(true, forKey: "isAuth")
    }
    
    func setNotIsAuth() {
        debugPrint("false is Auth")
        UserDefaults.standard.set(false, forKey: "isAuth")
    }
}
