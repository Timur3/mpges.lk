//
//  PaymentsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import RealmSwift

public protocol PaymentsTVControllerDelegate: class {
    func navigationPaymentInfoPage(payment: PaymentModel)
}

protocol PaymentsTVControllerUserDelegate {
    func setPayments(payments:PaymentsModelRoot)
    func refreshData()
    func getDataForRealm()
    func mapToPaymentsModelView(payments:[PaymentModel]) -> [PaymentsModelVeiw]
}

class PaymentsTVController: UITableViewController {
    public weak var delegate: PaymentsTVControllerDelegate?
    private var searchController = UISearchController(searchResultsController: nil)
    var contractId: Int = 0
    @IBAction func payAction(_ sender: Any) {
        AlertControllerAdapter.shared.show(title: "Внимание!", mesg: "Фукнционал оплаты временно приостановлен.", form: self)
    }
    private var tempPayments = [PaymentModel]()
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }
    var paymentsList = [PaymentsModelVeiw]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "История платежей"
        super.viewDidLoad()
        configuration()
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return paymentsList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(paymentsList[section].year)" + " год"
    }
 
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Количество записей: " + "\(paymentsList[section].payments.count)" + " на сумму: " + "\(paymentsList[section].payments.map({ $0.summa }).reduce(0, +))"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsList[section].payments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTVCell
        
        cell.update(for: paymentsList[indexPath.section].payments[indexPath.row])
        cell.imageView?.image = UIImage(systemName: myImage.rub.rawValue)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let paymentSend = paymentsList[indexPath.section].payments[indexPath.row]
        self.delegate?.navigationPaymentInfoPage(payment: paymentSend)
    }
}

// MARK: - SEARCH
extension PaymentsTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (!searchBarIsEmpty) {
            filterContent(searchController.searchBar.text!)
        } else { paymentsList = mapToPaymentsModelView(payments: tempPayments) }
    }
    private func filterContent(_ searchText: String)
    {
//       paymentsList = mapToPaymentsModelView(payments: tempPayments.filter({ (contractList: PaymentModel) -> Bool in
            //return tempPayments.summa.lowercased().contains(searchText.lowercased())
//        }))
    }
    
}
// MARK: - USER DELEGATE
extension PaymentsTVController: PaymentsTVControllerUserDelegate {
    func mapToPaymentsModelView(payments: [PaymentModel]) -> [PaymentsModelVeiw] {
        var res = [PaymentsModelVeiw]()
        let models = payments.groupBy { $0.payYear() }
        for mod in models{
            let payVM = PaymentsModelVeiw(year: mod.key, payments: mod.value as [PaymentModel])
            res.append(payVM)
        }
        return res.sorted(by: { $0.year > $1.year })
    }
    
    // получение данных из Realm, лишний раз не отправлять запрос на сервер
    func getDataForRealm(){
        let predicate = NSPredicate(format: "contractId == " + "\(contractId)")
        
        let paymentsRM = (DataProviderService.shared.getObjects(predicate: predicate) as [PaymentModel])
        if (paymentsRM.count) > 0 {
            self.paymentsList = mapToPaymentsModelView(payments: paymentsRM)
            ActivityIndicatorViewService.shared.hideView()
        } else {
            ApiServiceAdapter.shared.getPaymentsByContractId(id: contractId, delegate: self)
        }
    }
    
    @objc func refreshData() {
        print("refresh")
        ApiServiceAdapter.shared.getPaymentsByContractId(id: contractId, delegate: self)
        self.refreshControl?.endRefreshing()
    }

    func setPayments(payments: PaymentsModelRoot) {
        // todo доделать получение данных из realm
        let model = mapToPaymentsModelView(payments: payments.data)
        paymentsList = model
        // для поиска
        tempPayments = payments.data
        
        DataProviderService.shared.saveObjects(payments.data)
        ActivityIndicatorViewService.shared.hideView()
    }
}

//MARK: - CONFIGURATION
extension PaymentsTVController {
    private func configuration() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите сумму для поиска"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "PaymentTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "paymentCell")
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        getDataForRealm()
        tableView.delegate = self
    }
}
