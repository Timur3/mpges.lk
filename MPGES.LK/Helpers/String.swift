//
//  String.swift
//  mpges.lk
//
//  Created by Timur on 10.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

func formatRusCurrency(for string: String) -> String {
    let f = Float(string)
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.numberStyle = .currency
    return formatter.string(for: f)!
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
