//
//  ContractDetailsInfoTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 01.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

protocol ContractDetailsInfoTVControllerDelagate {
    
    func getCustomCell(textLabel: String, textAlign: NSTextAlignment, accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell
    func setContractById(contract: ContractModel)
}
