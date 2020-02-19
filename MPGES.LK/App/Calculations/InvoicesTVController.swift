//
//  CalculationsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class InvoicesTVController: UITableViewController {
    var userDataService = UserDataService()
    
    // для поиска todo
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
                    //searchBar.delegate = self
                }
            }
            
    var invoiceList = [InvoiceModel]() {
    didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
            
    override func viewDidLoad() {
        navigationItem.title = "История начислений"
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataContract), for: UIControl.Event.valueChanged)

        refreshDataContract(sender: self)
                
        tableView.delegate = self
        tableView.dataSource = self
    }
    
@objc func refreshDataContract(sender: AnyObject){
    print("refresh")
    ApiServiceAdapter.shared.getInvoiceByContractId(delegate: self)
    self.refreshControl?.endRefreshing()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

    // MARK: - Table view data source
override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return sections.count
}

override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section]
}
    
override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "Всего записей: " + String(invoiceList.count)
    }
            
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return invoiceList.count
    }

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTVCell
    cell.update(for: invoiceList[indexPath.row])
    return cell
    }
            
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let dataSend = invoiceList[indexPath.row]
    performSegue(withIdentifier: "goToCalculations", sender: dataSend)
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToCalculations", let invoice = sender as! InvoiceModel? {
            userDataService.setCurrentInvoice(invoice: invoice)
        }
}

    // Override to support editing the table view.
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        invoiceList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    } else if editingStyle == .insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension InvoicesTVController: UISearchBarDelegate, InvoicesTVControllerDelegate {
    
    var sections: [String] { ["Реестр квитанций"] }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                print("search")
        }
    func setInvoices(invoices: InvoiceModelRoot) {
        // todo доделать получение данных из realm
        invoiceList = invoices.data
    }
}
