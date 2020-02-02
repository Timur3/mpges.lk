//
//  ContractsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractsTVController: UITableViewController, ContractsTVControllerDelegate {
    var userDataService = UserDataService()
    // для поиска todo
    @IBOutlet weak var searchBarPayments: UISearchBar! {
        didSet {
                //searchBar.delegate = self
            }
        }
    
    var contractList = [ContractModel]() {
        didSet {
            DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataContract), for: UIControl.Event.valueChanged)

        refreshDataContract(sender: self)
            
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshDataContract(sender: AnyObject){
            print("refresh")
            ApiServiceAdapter.shared.getContracts(delegate: self)
            self.refreshControl?.endRefreshing()
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
            return "Список услуг"
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            return "Всего записей: " + String(contractList.count)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return contractList.count
        }
        
        @IBAction func newFriendPressed(_ sender: UIBarButtonItem) {
            performSegue(withIdentifier: "addContract", sender: nil)
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contractCell", for: indexPath) as! ContractsTVCell
            cell.contract = contractList[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let dataSend = contractList[indexPath.row]
            performSegue(withIdentifier: "contractInfo", sender: dataSend)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "contractInfo", let contractInfo = sender as! ContractModel? {
                userDataService.setCurrentContract(contract: contractInfo)
            }
        }
        
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                contractList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
    }

extension ContractsTVController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("search")
        }
    func getContractById(contract: [ContractModel]) {
            
        }
    func setContracts(contracts: ContractModelRoot) {
            // todo доделать получение данных из realm
            contractList = contracts.data
        }
}
