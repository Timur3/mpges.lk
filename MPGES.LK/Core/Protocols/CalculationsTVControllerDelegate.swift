//
//  CalculationsTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 08.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol CalculationsTVControllerDelegate {
    var sections: [String] { get }
    func setCalculations(payments:ResultModel<[PaymentModel]>)
}
