//
//  TableViewCellHelper.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomCell(textLabel: String, textAlign: NSTextAlignment, textColor: UIColor = .black, accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell {
    
    let cell = UITableViewCell()
    cell.imageView?.image = UIImage(systemName: myImage.Rub.rawValue)
    cell.textLabel?.text = textLabel
    cell.textLabel?.textColor = textColor
    cell.textLabel?.textAlignment = textAlign
    cell.accessoryType = accessoryType
    return cell
    
}

enum myImage: String {
    case Rub = "rublesign.circle"
    
}
