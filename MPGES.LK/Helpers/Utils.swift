//
//  Utils.swift
//  mpges.lk
//
//  Created by Timur on 06.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation

class Utils {

    private static let amountFormatter = NumberFormatter()

    static func formatAmount(_ value: NSDecimalNumber, fractionDigits: Int = 2, currency: String = "₽") -> String {
        amountFormatter.usesGroupingSeparator = true
        amountFormatter.groupingSize = 3
        amountFormatter.groupingSeparator = " "
        amountFormatter.alwaysShowsDecimalSeparator = false
        amountFormatter.decimalSeparator = ","
        amountFormatter.minimumFractionDigits = 0
        amountFormatter.maximumFractionDigits = fractionDigits

        return "\(amountFormatter.string(from: value) ?? "\(value)") \(currency)"
    }
}
