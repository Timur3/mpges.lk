//
//  TableViewCellHelper.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

func getCustomCell(textLabel: String, textAlign: NSTextAlignment, accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell {
    
    let cell = UITableViewCell()
    cell.textLabel?.text = textLabel
    cell.textLabel?.textAlignment = textAlign
    cell.accessoryType = accessoryType
    return cell
    
}
