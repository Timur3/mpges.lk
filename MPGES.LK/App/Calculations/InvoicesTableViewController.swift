//
//  CalculationsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoicesTableViewControllerDelegate: class {
    func navigantionInvoiceDetailsInfoPage(model: InvoiceModel)
    }

protocol InvoicesTableViewControllerUserDelegate: class {
    var sections: [String] { get }
    func setInvoices(invoices:InvoiceModelRoot)
    }

class InvoicesTableViewController: UITableViewController {
    public var contractId: Int = 0
    public weak var delegate: InvoicesTableViewControllerDelegate?
    var invoiceList = [InvoiceModelVeiw]() {
    didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
            
    override func viewDidLoad() {
        navigationItem.title = "История начислений"
        super.viewDidLoad()
        configuration()
    }
    
@objc func refreshInvoicesData(sender: AnyObject){
    print("refresh")
    ApiServiceAdapter.shared.getInvoicesByContractId(id: contractId, delegate: self)
    self.refreshControl?.endRefreshing()
    }

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return invoiceList.count
    }

override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "\(invoiceList[section].year)" + " год"
    }
    
override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "Всего записей: " + String(invoiceList[section].invoices.count)
    }
            
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return invoiceList[section].invoices.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTVCell
        cell.imageView?.image = UIImage(systemName: myImage.textPlus.rawValue)
        cell.update(for: invoiceList[indexPath.section].invoices[indexPath.row])
        return cell
    }
            
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let invoice = invoiceList[indexPath.section].invoices[indexPath.row]
    self.delegate?.navigantionInvoiceDetailsInfoPage(model: invoice)
    
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension InvoicesTableViewController: InvoicesTableViewControllerUserDelegate {
    func mapToInvoicesModelView(invoices: [InvoiceModel]) -> [InvoiceModelVeiw] {
        var res = [InvoiceModelVeiw]()
        let models = invoices.groupBy { $0.year}
         for mod in models{
             let invVM = InvoiceModelVeiw(year: mod.key, invoices: mod.value as [InvoiceModel])
             res.append(invVM)
         }
         return res.sorted(by: { $0.year > $1.year })
    }
    var sections: [String] { ["Реестр квитанций"] }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                print("search")
    }
    func setInvoices(invoices: InvoiceModelRoot) {
        // todo получение данных из realm
        invoiceList = mapToInvoicesModelView(invoices: invoices.data)
    }
}

extension InvoicesTableViewController {
    func configuration() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshInvoicesData), for: UIControl.Event.valueChanged)
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "InvoiceTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "invoiceCell")
        self.tableView.dataSource = self
        refreshInvoicesData(sender: self)
                
        tableView.delegate = self
        tableView.dataSource = self
    }
}
