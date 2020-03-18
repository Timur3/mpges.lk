//
//  ContractDetailsInfoTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 01.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

protocol ContractDetailsInfoTVControllerUserDelegate {
    var sections: [String] { get }
    func setContractById(contract: ContractModel)
}
