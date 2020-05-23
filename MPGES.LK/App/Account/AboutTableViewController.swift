//
//  AboutTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 22.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class AboutTableViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension AboutTableViewController {
     private func configuration() {
           let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
           self.navigationItem.rightBarButtonItems = [cancelBtn]
           self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
           self.hideKeyboardWhenTappedAround()
       }
       
       func updateTableViewContentInset() {
           let viewHeight: CGFloat = view.frame.size.height
           let tableViewContentHeight: CGFloat = tableView.contentSize.height
           let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
           self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
       }
}
