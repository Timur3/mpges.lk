//
//  ContractsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol ContractsTVControllerDelegate: class {
    func navigationAddPage()
    func navigationDetailsInfoPage(to contract: ContractModel)
}

public protocol ContractsTVControllerUserDelegate: class {
    var sections: [String] { get }
    func getContracts()
    func setContracts(contracts: ContractModelRoot)
    func resultRemoveContractBinding(result: ServerResponseModel)
}

class ContractsTVController: UITableViewController {
    
    public weak var delegate: ContractsTVControllerDelegate?
    public weak var delegateUser: ContractsTVControllerUserDelegate?
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var tempContractList = [ContractModel]()
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }

    private var contractList = [ContractModel]() {
        didSet {
            DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Мои услуги"
        super.viewDidLoad()
        Configuration()
    }
    
    @objc func navigateACP()
    {
        self.delegate?.navigationAddPage()
    }
    
    @objc func refreshDataContract(sender: AnyObject) {
        self.getContracts()
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
        
        // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Всего записей: " + String(contractList.count)
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contractList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contractCell", for: indexPath) as! ContractsTableViewCell
        cell.imageView?.image = UIImage(systemName: myImage.docText.rawValue)
        cell.contract = contractList[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contractDI = contractList[indexPath.row]
        self.delegate?.navigationDetailsInfoPage(to: contractDI)
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let model = ContractNumberModel(number: contractList[indexPath.row].number)
                contractList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                ApiServiceAdapter.shared.removeContractBinding(model: model, delegate: self)
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
    }
// MARK: - SEARCH
extension ContractsTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (!searchBarIsEmpty) {
            filterContent(searchController.searchBar.text!)
        } else { contractList = tempContractList }
    }
    private func filterContent(_ searchText: String)
    {
        contractList = tempContractList.filter({ (contractList: ContractModel) -> Bool in
            return "\(contractList.id)".lowercased().contains(searchText.lowercased())
        })
    }
    
}

// MARK: - USER DELEGATE

extension ContractsTVController: ContractsTVControllerUserDelegate {
    
    func getContracts() {
        ApiServiceAdapter.shared.getContracts(delegate: self)
        self.refreshControl?.endRefreshing()
    }
    
    func resultRemoveContractBinding(result: ServerResponseModel) {
        debugPrint("Success")
    }
    var sections: [String] { ["Список действующих услуг"] }
    func getContractById(contract: [ContractModel]) {
        
    }
    func setContracts(contracts: ContractModelRoot) {
        // todo доделать получение данных из realm
        contractList = contracts.data
        // для поиска
        tempContractList = contracts.data
    }
}

// MARK: - CONFIGURE
extension ContractsTVController {
    
private func Configuration() {
    self.refreshControl = UIRefreshControl()
    let addContract = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateACP))
    self.navigationItem.rightBarButtonItems = [addContract]
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Введите номер договора"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    let nib = UINib(nibName: "ContractsTableViewCell", bundle: nil)
    self.tableView.register(nib, forCellReuseIdentifier: "contractCell")
    self.tableView.dataSource = self
    self.refreshControl?.addTarget(self, action: #selector(refreshDataContract), for: UIControl.Event.valueChanged)
    refreshDataContract(sender: self)
    tableView.delegate = self
    tableView.dataSource = self
    delegateUser = self
    }
}
