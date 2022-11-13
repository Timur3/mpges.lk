//
//  Decimal+Extension.swift
//  mpges.lk
//
//  Created by Timur on 14.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

extension Decimal {
    
    func toString() -> String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSDecimalNumber)!
    }
}
