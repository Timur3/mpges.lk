//
//  PaymentsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PaymentsTVController: UITableViewController, PaymentsTVControllerDelegate {
    
    let methodApi = MethodApi()
    
    // для поиска todo
    @IBOutlet weak var searchBarPayments: UISearchBar! {
        didSet {
            //searchBarMyFriends.delegate = self
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
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(refreshDataPayments), for: UIControl.Event.valueChanged)
       
        //let friendsRM = dp.getObjects() as [User]
        //if (friendsRM.count) > 0 {
        //    self.myListFriends = friendsRM
        //} else {
            refreshDataPayments(sender: self)
        //}
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshDataPayments(sender: AnyObject){
        print("refresh")
        ApiService.shared.requestById(id: 4, method: methodApi.getPaymentsByContractId, completion: setPayments(payments:))
        self.refreshControl?.endRefreshing()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "ИТОГО: " + String(paymentsList.count) + "  СУММА: 0.00"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsList.count
    }
    
    @IBAction func newFriendPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "searchPayment", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTVCell
        cell.payment = paymentsList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let friendSend = paymentsList[indexPath.row]
        performSegue(withIdentifier: "paymentInfo", sender: friendSend)
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

extension PaymentsTVController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search")
    }
    
    func setPayments(payments: PaymentsModelRoot) {
        // todo доделать получение данных из realm
        paymentsList = payments.data
    }
}
