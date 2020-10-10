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
    formatter.decimalSeparator = "."
    return formatter.string(for: f)!
}

extension String {
func removeFormatAmount() -> Double {
    let formatter = NumberFormatter()

    formatter.locale = Locale(identifier: "ru_RU")
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.decimalSeparator = " "

    return formatter.number(from: self) as! Double? ?? 0
 }
    func removeFormatAndSpace() -> Decimal {
        let text = self.replacingOccurrences(of: "₽", with: "").replacingOccurrences(of: ",", with: ".")
        let trimmedString = text.components(separatedBy: .whitespaces).joined()
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .none
        
        if let number = formatter.number(from: trimmedString) {
            let amount = number.decimalValue
            return amount
        }
        return 0.00
    }
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
