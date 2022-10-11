//
//  TableViewCellHelper.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomCell(textLabel: String, imageCell: myImage = .none, textAlign: NSTextAlignment, textColor: UIColor = .black, accessoryType: UITableViewCell.AccessoryType, isUserInteractionEnabled: Bool = true, style: UITableViewCell.CellStyle = .default, customImage: String = "", selectionStyle: UITableViewCell.SelectionStyle = .default) -> UITableViewCell {
    
    let cell = UITableViewCell(style: style, reuseIdentifier: "")
    if (imageCell != .none) {
        cell.imageView?.image =  UIImage(systemName: imageCell.rawValue)
    }
    
    if !customImage.isEmpty {
        cell.imageView?.image = UIImage(systemName: customImage)
    }
    
    if (selectionStyle != .default) {
        cell.selectionStyle = selectionStyle
    }
    
    cell.textLabel?.text = textLabel
    if (textColor != .black) {
        cell.textLabel?.textColor = textColor
    }
    cell.textLabel?.textAlignment = textAlign
    cell.accessoryType = accessoryType
    cell.isUserInteractionEnabled = isUserInteractionEnabled
    
    return cell
    
}
