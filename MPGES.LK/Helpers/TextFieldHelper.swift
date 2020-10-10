//
//  TextFieldHelper.swift
//  mpges.lk
//
//  Created by Timur on 24.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomTextField(placeholder: String, keyboardType: UIKeyboardType = .default, isPassword: Bool = false) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.keyboardType = keyboardType
    textField.isSecureTextEntry = isPassword
    return textField
}

func isValidSumma(tf: UITextField) -> Bool {
    let isValid = true
    if tf.text!.isEmpty { return false }

    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.numberStyle = .currency
    
    guard let number = formatter.number(from: tf.text!) else { return false }
    let amount = number.decimalValue
    if amount < 0.00 { return false }
    
    return isValid
}
