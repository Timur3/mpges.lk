//
//  ContractsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol ContractsTVControllerDelegate: class {
    func navigationContractAddTVPage(delegate: ContractsTVControllerUserDelegate)
    func navigationDetailsInfoPage(to contract: ContractModel)
}

public protocol ContractsTVControllerUserDelegate: class {
    func getContracts()
    func setContracts(contracts: ResultModel<[ContractModel]>)
    func resultRemoveContractBinding(result: ResultModel<String>)
}

class ContractsTVController: UITableViewController {
    public weak var mainCoordinator: MainCoordinator?
    public weak var delegate: ContractsTVControllerDelegate?
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
        ActivityIndicationService.shared.showView(form: self.view)
        self.navigationItem.title = "Мои договоры"
        super.viewDidLoad()
        configuration()
    }
    
    @objc func alertSheetContractAddShow() {
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let actionAddExistContract = UIAlertAction(title: "Добавить существующий договор", style: .default) {
            (UIAlertAction) in self.showContractAddTVPage()
        }
        //let actionNewContract = UIAlertAction(title: "Заключить новый договор", style: .default) {
        //  (UIAlertAction) in self.showNewContractPage()
        //}
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionAddExistContract)
        //alert.addAction(actionNewContract)
        alert.addAction(actionCancel)
        
        if UIDevice.isPad {
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
          }
        }
        self.present(alert, animated: true, completion: nil)
    }
   
    func showContractAddTVPage() {
        self.delegate?.navigationContractAddTVPage(delegate: self)
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
        return contractList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Договор заключен: " + contractList[section].dateRegister
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contractCell", for: indexPath) as! ContractsTableViewCell
        cell.imageView?.image = UIImage(systemName: myImage.docText.rawValue)
        cell.update(for: contractList[indexPath.section])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contract = contractList[indexPath.section]
        self.delegate?.navigationDetailsInfoPage(to: contract)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alertSheetOfDelBindingShow(for: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func alertSheetOfDelBindingShow(for indexPath: IndexPath){
        self.showActionSheetConfirm(title: "Внимание!", mesg: "Вы действительно хотите удалить договор из списка услуг?", handlerYes: { (UIAlertAction) in
            ActivityIndicationService.shared.showView(form: self.view)
            let model = ContractNumberModel(number: self.contractList[indexPath.section].number)
            ApiServiceWrapper.shared.removeContractBinding(model: model, delegate: self)
        })
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
        ApiServiceWrapper.shared.getContracts(delegate: self)
        self.refreshControl?.endRefreshing()
    }
    
    func resultRemoveContractBinding(result: ResultModel<String>) {
        self.getContracts()
        debugPrint("Success")
    }
    func setContracts(contracts: ResultModel<[ContractModel]>) {
        // todo доделать получение данных из realm
        contractList = contracts.data!
        // для поиска
        tempContractList = contracts.data!
        
        ActivityIndicationService.shared.hideView()
    }
}

// MARK: - CONFIGURE
extension ContractsTVController {
    
    private func configuration() {
        self.refreshControl = UIRefreshControl()
        let addContract = getPlusUIBarButtonItem(target: self, action: #selector(alertSheetContractAddShow))
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
    }
}
