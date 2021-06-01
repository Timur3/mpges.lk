//
//  ActivityIndicatorViewForCellService.swift
//  mpges.lk
//
//  Created by Timur on 03.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class ActivityIndicatorViewForCellService {
    public static let shared = ActivityIndicatorViewForCellService()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    func showAI(cell: UITableViewCell) {
        DispatchQueue.main.async {
            let cellHeight = (cell.bounds.height)
            let cellWidth = (cell.bounds.width)
            self.activityIndicator.startAnimating()
            self.activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: cellWidth, height: cellHeight)
            self.activityIndicator.backgroundColor = .systemBackground
            cell.textLabel?.isHidden = true
            cell.detailTextLabel?.isHidden = true
            cell.isUserInteractionEnabled = false
            cell.contentView.addSubview(self.activityIndicator)
        }
    }
    
    func hiddenAI(cell: UITableViewCell) {
        DispatchQueue.main.async {
            cell.textLabel?.isHidden = false
            cell.detailTextLabel?.isHidden = false
            cell.isUserInteractionEnabled = true
            self.activityIndicator.removeFromSuperview()
        }
    }
}
