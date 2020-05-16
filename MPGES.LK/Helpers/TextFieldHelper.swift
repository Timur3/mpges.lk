//
//  TextFieldHelper.swift
//  mpges.lk
//
//  Created by Timur on 24.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomTextField(placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
}
