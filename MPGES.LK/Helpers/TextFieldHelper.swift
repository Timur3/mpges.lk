//
//  TextFieldHelper.swift
//  mpges.lk
//
//  Created by Timur on 24.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomTextField(placeholder: String, translatesAutoresizingMaskIntoConstraints: Bool) -> UITextField {
    let textField = UITextField()
    textField.placeholder = "Ваш email адрес"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
}
