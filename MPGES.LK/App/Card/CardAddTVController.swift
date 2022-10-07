//
//  CardAddTVController.swift
//  mpges.lk
//
//  Created by Timur on 23.07.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit

class CardAddTVController: CommonTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.navigationItem.title = NSLocalizedString("title.cardAdd", comment: "Добавить карту")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func refreshData() {
        
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
