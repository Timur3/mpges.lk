//
//  ContractsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol ContractsTVControllerDelegate: AnyObject {
    func navigationContractAddTVPage(delegate: ContractsTVControllerUserDelegate)
    func navigationDetailsInfoPage(to contractId: Int)
}

public protocol ContractsTVControllerUserDelegate: AnyObject {
    func getContracts()
    func setContracts(contracts: ResultModel<[ContractModel]>)
    func resultRemoveContractBinding(result: ResultModel<String>)
}

class ContractsTVController: CommonViewController {
    public weak var mainCoordinator: MainCoordinator?
    public weak var delegate: ContractsTVControllerDelegate?
    private var searchController = UISearchController(searchResultsController: nil)
    private var tempContractList = [ContractModel]()
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }
    
    private lazy var contractTable: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: ContractTableViewCell.identifier, bundle: nil)
        table.register(nib, forCellReuseIdentifier: ContractTableViewCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var contractList = [ContractModel]() {
        didSet {
            DispatchQueue.main.async {
                self.contractTable.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = NSLocalizedString("title.myContracts", comment: "Мои договора")
        super.viewDidLoad()
        configuration()
        getContracts()
    }
    
    private func configuration() {
        self.contractTable.refreshControl = UIRefreshControl()
        let addContract = getPlusUIBarButtonItem(target: self, action: #selector(alertSheetContractAddShow))
        self.navigationItem.rightBarButtonItems = [addContract]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите номер договора"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.contractTable.refreshControl?.addTarget(self, action: #selector(getDataContracts), for: UIControl.Event.valueChanged)
        
        view.addSubview(contractTable)
        NSLayoutConstraint.activate([
            contractTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            contractTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            contractTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            contractTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func getDataContracts() {
        self.getContracts()
    }
    
    @objc func alertSheetContractAddShow() {
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let actionAddExistContract = UIAlertAction(title: "Добавить существующий договор", style: .default) {
            (UIAlertAction) in self.showContractAddTVPage()
        }
        let actionNewContract = UIAlertAction(title: "Заключить новый договор", style: .default) {
            (UIAlertAction) in self.showNewContractPage()
        }
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
    
    func showNewContractPage() {
        //self.view.addSubview(LoadingIndicatorViewController().view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertSheetOfDelBindingShow(for indexPath: IndexPath){
        self.showActionSheetConfirm(title: "Внимание!", message: "Вы действительно хотите исключить договор из списка услуг?", handlerYes: { (UIAlertAction) in
            let model = ContractNumberModel(number: self.contractList[indexPath.section].number)
            ApiServiceWrapper.shared.removeContractBinding(model: model, delegate: self)
        })
    }
}

//MARK: - UITableViewDelegate
extension ContractsTVController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Договор заключен: " + contractList[section].dateRegister
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContractTableViewCell.identifier, for: indexPath) as? ContractTableViewCell
        guard let tableCell = cell else { return UITableViewCell() }
        tableCell.update(for: contractList[indexPath.section])
        return tableCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contract = contractList[indexPath.section]
        self.delegate?.navigationDetailsInfoPage(to: contract.id)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alertSheetOfDelBindingShow(for: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - UITableViewDataSource
extension ContractsTVController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contractList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ApiServiceWrapper.shared.getContracts(delegate: self)
            self.contractTable.refreshControl?.endRefreshing()
        }
    }
    
    func resultRemoveContractBinding(result: ResultModel<String>) {
        showToast(message: "Договор отвязан")
        self.getContracts()
    }
    
    func setContracts(contracts: ResultModel<[ContractModel]>) {
        // todo доделать получение данных из realm
        contractList = contracts.data!
        // для поиска
        tempContractList = contracts.data!
    }
}
