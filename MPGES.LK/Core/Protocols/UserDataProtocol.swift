//
//  UserDataProtocol.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol UserDataProtocol {
    
    func saveData(token: String, userId: Int)
    func setCurrentContractor(contractorId: Int)
    func getCurrentContractor() -> Int?
    
    func setCurrentInvoice(invoiceId: Int)
    func getCurrentInvoice() -> Int?
    
    func getToken() -> String?
    func getCurrentUserId() -> Int?
    func delData()
    
}
