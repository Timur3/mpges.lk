//
//  PaymentsViewController.swift
//  mpges.lk
//
//  Created by Timur on 17.01.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit
import SafariServices

protocol PaymentsViewControllerUserDelegate {
    func setPayments(payments:ResultModel<[PaymentModel]>)
    func getPayments()
    func mapToPaymentsModelView(payments:[PaymentModel]) -> [PaymentsModelVeiw]
    func navigationPaymentInfoForSafariService(for model: ResultModel<String>)
}

class PaymentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
    
    private var tempPayments = [PaymentModel]()
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }
    private var searchController = UISearchController(searchResultsController: nil)
    var contractId: Int = 0
    
    var paymentsList = [PaymentsModelVeiw]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Платежи"
        configuration()
        setUpLayout()
        getPayments()
    }
    
    private func configuration(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите сумму для поиска"
        definesPresentationContext = true
        
        let nib = UINib(nibName: "PaymentTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "paymentCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(getPayments), for: UIControl.Event.valueChanged)
        
        self.view.backgroundColor = self.tableView.backgroundColor
    }
    
    func setUpLayout(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationItem.searchController = searchController
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return (paymentsList.count == 0) ? 2 : paymentsList.count
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print("did End Displaying Header View")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scroll")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("did End Displaying Footer View")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return paymentsList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = paymentsList[section].payments.count
        let sum = paymentsList[section].payments.map({ $0.summa }).reduce(0, +)
        let msg = "Всего записей: \(count) на сумму \(formatRusCurrency(sum))"
        return "\(paymentsList[section].year) год\n\(msg)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsList[section].payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTVCell.identifier, for: indexPath) as! PaymentTVCell
        
        cell.update(for: paymentsList[indexPath.section].payments[indexPath.row])
        cell.imageView?.image = UIImage(systemName: myImage.rub.rawValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let pay = paymentsList[indexPath.section].payments[indexPath.row]
        ApiServiceWrapper.shared.getReceiptUrl(id: pay.id, delegate: self)
    }
}

extension PaymentsViewController: PaymentsViewControllerUserDelegate {
    func navigationPaymentInfoForSafariService(for model: ResultModel<String>) {
        let isError = model.isError
        if (!isError) {
            if let url = URL(string: model.data!) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                self.present(vc, animated: true, completion: nil)
            }
        }
        else
        {
            self.showAlert(
                title: "Ошибка",
                mesg: model.message!) { (UIAlertAction) in
                print(model.message as Any)
            }
        }
    }

@objc func getPayments() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        let access = ApiService.Connectivity.isConnectedToInternet
        if access {
            print("refresh")
            ApiServiceWrapper.shared.getPaymentsByContractId(id: self.contractId, delegate: self)
        } else {
            let msg = "Нет соединения с интернетом, попробуйте выполнить запрос позже"
            self.showAlert(
                title: "Ошибка",
                mesg: msg) { (UIAlertAction) in
                print(msg as Any)
            }
        }
        self.tableView.refreshControl?.endRefreshing()
    }
}

func mapToPaymentsModelView(payments: [PaymentModel]) -> [PaymentsModelVeiw] {
    var res = [PaymentsModelVeiw]()
    let models = payments.groupBy { $0.payYear() }
    for mod in models{
        let payVM = PaymentsModelVeiw(year: mod.key, payments: mod.value as [PaymentModel])
        res.append(payVM)
    }
    return res.sorted(by: { $0.year > $1.year })
}

func setPayments(payments: ResultModel<[PaymentModel]>) {
    // todo доделать получение данных из realm
    let model = mapToPaymentsModelView(payments: payments.data!)
    paymentsList = model
    // для поиска
    tempPayments = payments.data!
}
}
// MARK: - SEARCH
extension PaymentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (!searchBarIsEmpty) {
            filterContent(searchController.searchBar.text!)
        } else { paymentsList = mapToPaymentsModelView(payments: tempPayments) }
    }
    private func filterContent(_ searchText: String)
    {
        paymentsList = mapToPaymentsModelView(payments: tempPayments.filter({ (payList: PaymentModel) -> Bool in
            return payList.summa >= Double(searchText) ?? 0.00
        }))
        print("поиск в платежах")
    }
    
}
