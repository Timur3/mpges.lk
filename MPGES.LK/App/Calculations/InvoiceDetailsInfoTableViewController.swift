//
//  InvoiceDetailsInfoTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoiceDetailsInfoTableViewControllerDelegate: class {
    func navigantionInvoicePage()
}

protocol InvoiceDetailsInfoTableViewControllerUserDelegate: class {
    var sections: [String] { get }
}

class InvoiceDetailsInfoTableViewController: UITableViewController {
    public weak var delegate: InvoiceDetailsInfoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Детали";
        super.viewDidLoad()
        configuration()
    }
    weak var invoiveDetails: InvoiceDetailsModelView? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return invoiveDetails?.calc.count ?? 0
        }
        return invoiveDetails?.pay.count ?? 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath) as! CalculationTVCell
            cell.update(for: (invoiveDetails?.calc[indexPath.row])!)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentTVCell", for: indexPath) as! PaymentTVCell
        cell.update(for: (invoiveDetails?.pay[indexPath.row])!)
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension InvoiceDetailsInfoTableViewController: InvoiceDetailsInfoTableViewControllerUserDelegate {
    var sections: [String] {
        ["Начислено", "Оплачено"]
    }
}

//MARK: - CONFIGURATION
extension InvoiceDetailsInfoTableViewController {
    func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        let nibCalc = UINib(nibName: "CalculationTVCell", bundle: nil)
        self.tableView.register(nibCalc, forCellReuseIdentifier: "calculationCell")
        let nibPay = UINib(nibName: "PaymentTVCell", bundle: nil)
        self.tableView.register(nibPay, forCellReuseIdentifier: "paymentTVCell")
    }
}
