//
//  CenterContentTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 08.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class CenterContentAndCommonTableViewController: CommonTableViewController {
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0)
    }
    
    override func viewWillLayoutSubviews() {
        self.updateTableViewContentInset()
    }
}
