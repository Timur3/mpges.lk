//
//  TableViewCellHelper.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomCell(textLabel: String, imageCell: myImage = .none, textAlign: NSTextAlignment, textColor: UIColor = .black, accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell {
    
    let cell = UITableViewCell()
    if (imageCell != .none) {
        cell.imageView?.image =  UIImage(systemName: imageCell.rawValue)
    }
    cell.textLabel?.text = textLabel
    if (textColor != .black) {
        cell.textLabel?.textColor = textColor
    }
    cell.textLabel?.textAlignment = textAlign
    cell.accessoryType = accessoryType
    return cell
    
}
