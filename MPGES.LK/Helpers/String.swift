//
//  String.swift
//  mpges.lk
//
//  Created by Timur on 10.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

func formatRusCurrency(_ string: String) -> String {
    let f = Decimal(string: string)
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.numberStyle = .currency
    //formatter.decimalSeparator = "."
    return formatter.string(for: f)!
}
func formatRusCurrency(_ number: Double) -> String {
    return formatRusCurrency("\(number)")
}

func removeFormatAndSpace(for string: String) -> Double {
    let text = string.replacingOccurrences(of: "₽", with: "").replacingOccurrences(of: ".", with: ",")
    let trimmedString = text.components(separatedBy: .whitespaces).joined()
    
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .decimal
    
    if let number = formatter.number(from: trimmedString) {
        let amount = number.doubleValue
        return amount
    }
    return 0.00
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
