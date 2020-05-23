//
//  MyTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 23.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class CommonTableViewController: UITableViewController {
    public var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hiddenAI(){
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
