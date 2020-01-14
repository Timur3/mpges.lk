//
//  UserDataService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
class UserDataService: UserDataProtocol {

    func saveData(token: String, userId: Int) {
        UserDefaults.standard.set(token, forKey: "accessToken")
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func setCurrentContractor(contractorId: Int) {
        UserDefaults.standard.set(contractorId, forKey: "contractorId")
    }
    
    func getCurrentContractor() -> Int? {
        return UserDefaults.standard.integer(forKey: "contractorId")
    }
    
    func setCurrentInvoice(invoiceId: Int) {
        UserDefaults.standard.set(invoiceId, forKey: "invoiceId")
    }
    
    func getCurrentInvoice() -> Int? {
        return UserDefaults.standard.integer(forKey: "invoiceId")
    }
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func getCurrentUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "userId")
    }
    
    func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "userId")
        UserDefaults.standard.set("", forKey: "contractorId")
        UserDefaults.standard.set("", forKey: "invoiceId")
    }
}
