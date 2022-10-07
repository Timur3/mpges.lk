//
//  CardsTVController.swift
//  mpges.lk
//
//  Created by Timur on 23.07.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit

class CardsTVController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        self.navigationItem.title = NSLocalizedString("title.paymentCardList", comment: "Список карт")
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let plusBtn = getPlusUIBarButtonItem(target: self, action: #selector(cardAdd))
        self.navigationItem.rightBarButtonItems = [plusBtn]
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func cardAdd() {
        let cardAddTVController = CardAddTVController()
        let navCardAddTVController: UINavigationController = UINavigationController(rootViewController: cardAddTVController)
        self.navigationController?.present(navCardAddTVController, animated: true)
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
