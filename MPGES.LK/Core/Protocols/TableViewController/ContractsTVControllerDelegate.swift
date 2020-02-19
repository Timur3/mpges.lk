//
//  ContractsTVCDelegate.swift
//  mpges.lk
//
//  Created by Timur on 27.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol ContractsTVControllerDelegate {
    var sections: [String] { get }
    func setContracts(contracts:ContractModelRoot)
    
}
