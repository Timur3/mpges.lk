//
//  PaymentsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import RealmSwift

class PaymentsTVController: UITableViewController {
    var contractId: Int = 0
    
    // для поиска todo
    @IBOutlet weak var searchBarPayments: UISearchBar! {
        didSet {
            //search.delegate = self
        }
    }
    
    var paymentsList = [PaymentModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "История платежей"
        super.viewDidLoad()        
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        ActivityIndicatorViewService.shared.showViewWinthoutBackground(form: self.tableView)
        getDataForRealm()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print("did End Displaying Header View")
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scroll")
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("did End Displaying Footer View")
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
        return "ИТОГО: " + String(paymentsList.count) + "  СУММА: 0.00"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTVCell
        cell.payment = paymentsList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let paymentSend = paymentsList[indexPath.row]
        performSegue(withIdentifier: "paymentInfo", sender: paymentSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentInfo", let paymentInfo = segue.destination as? PaymentInfoTVController {
            paymentInfo.payment = sender as? PaymentModel
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            paymentsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension PaymentsTVController: UISearchBarDelegate, PaymentsTVControllerDelegate {
    
    // получение данных из Realm, лишний раз не отправлять запрос на сервер
    func getDataForRealm(){
        let predicate = NSPredicate(format: "packId == " + "\(contractId)")
        
        let paymentsRM = (DataProviderService.shared.getObjects(predicate: predicate) as [PaymentModel])
        if (paymentsRM.count) > 0 {
            self.paymentsList = paymentsRM
            ActivityIndicatorViewService.shared.hideView()
        } else {
            ApiServiceAdapter.shared.getPaymentsByContractId(delegate: self)
        }
    }
    
    @objc func refreshData() {
        print("refresh")
        ApiServiceAdapter.shared.getPaymentsByContractId(delegate: self)
        self.refreshControl?.endRefreshing()
    }
    
    
    var sections: [String] { ["Текущий год", "Архив"] }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search")
    }
    
    func setPayments(payments: PaymentsModelRoot) {
        // todo доделать получение данных из realm
        DataProviderService.shared.saveObjects(payments.data)
        paymentsList = payments.data
        ActivityIndicatorViewService.shared.hideView()
    }   
}
