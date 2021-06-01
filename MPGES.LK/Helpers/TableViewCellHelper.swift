//
//  TableViewCellHelper.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomCell(textLabel: String, imageCell: myImage = .none, textAlign: NSTextAlignment, textColor: UIColor = .black, accessoryType: UITableViewCell.AccessoryType, isUserInteractionEnabled: Bool = true, style: UITableViewCell.CellStyle = .default) -> UITableViewCell {
    
    let cell = UITableViewCell(style: style, reuseIdentifier: "")
    if (imageCell != .none) {
        cell.imageView?.image =  UIImage(systemName: imageCell.rawValue)
    }
    
    cell.textLabel?.text = textLabel
    //cell.description = description
    if (textColor != .black) {
        cell.textLabel?.textColor = textColor
    }
    cell.textLabel?.textAlignment = textAlign
    cell.accessoryType = accessoryType
    cell.isUserInteractionEnabled = isUserInteractionEnabled
    
    //cell.textLabel?.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
    
    // skeletonView
    cell.textLabel?.isSkeletonable = true
    cell.contentView.isSkeletonable = true
    cell.isSkeletonable = true
    
    return cell
    
}
