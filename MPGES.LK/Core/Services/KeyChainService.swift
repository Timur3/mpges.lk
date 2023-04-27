//
//  KeyChainService.swift
//  mpges.lk
//
//  Created by Timur on 04.12.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import AuthenticationServices

final class KeyChain {
    private let service = "lk.mp-ges.ru"
    static let shared = KeyChain()
    
    func save(_ password: Data, account: String) {
        let query = [
            kSecValueData: password,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let saveStatus = SecItemAdd(query, nil)
        
        if saveStatus != errSecSuccess {
            print("Error: \(saveStatus)")
        }
        
        if saveStatus == errSecDuplicateItem {
            update(password, account: account)
        }
    }
    
    func update(_ password: Data, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
           // kSecClass: kSecSharedPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let updatedData = [kSecValueData: password] as CFDictionary
        SecItemUpdate(query, updatedData)
    }
    
    func read(account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            //kSecMatchLimit: kSecMatchLimitOne,
            //kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }
    
    func delete(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
