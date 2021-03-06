//
//  InvoiceDeliveryMethodsViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit
import SkeletonView

class InvoiceDeliveryMethodsViewController: UIViewController {
    
    weak var delegate: ContractDetailsInfoTVControllerUserDelegate?
    private var selectedDeliveryMethod: InvoiceDeliveryMethodModel?
    private lazy var tableView = UITableView.init(frame: .zero, style: .insetGrouped)
    private var indexPath: IndexPath?
    var contract: ContractModel?
    
    var deliveryOfInvoiceViewModel: TableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Доставка квитанций"
        setUpLayout()
        configuration()
        bindingData()
        //getData()
        //skeletonShow()
    }
    
    func configuration(){
        let nib = UINib(nibName: "InvoiceDeliveryMethodsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func setUpLayout(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func bindingData() {
        deliveryOfInvoiceViewModel = DeliveryOfInvoiceViewModel()
        guard let data = deliveryOfInvoiceViewModel?.deliveryOfInvoices else { return }
        var temp = [InvoiceDeliveryMethodModel]()
        for var item in data {
            if (item.id == self.contract?.invoiceDeliveryMethodId) {
                item.selected = true
                selectedDeliveryMethod = item
            }
            temp.append(item)
        }
        deliveryMethodList = temp
        setUpLayout()
        //skeletonStop()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContractById(id: contract!.id)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //ApiServiceWrapper.shared.getDeliveryOfInvoices(delegate: self)
        }
    }
    
    // MARK: - Table view data source
    var deliveryMethodList = [InvoiceDeliveryMethodModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Способы доставки квитанций"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: indexPath)!)
        
        deliveryMethodList[indexPath.row].selected = deliveryMethodList[indexPath.row].selected ? true : true
        selectedDeliveryMethod = deliveryMethodList[indexPath.row]
        var temp = [InvoiceDeliveryMethodModel]()
        for var item in deliveryMethodList {
            if (item.id != selectedDeliveryMethod!.id) { item.selected = false }
            temp.append(item)
        }
        deliveryMethodList = temp
        self.sendDeliveryMethod()
    }
    
    func sendDeliveryMethod() {
        let updDeliveryMethod = UpdateDeliveryMethodModel(contractId: contract!.id, deliveryMethodId: selectedDeliveryMethod!.id)
        //ApiServiceWrapper.shared.updateDeliveryMethod(model: updDeliveryMethod, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deliveryOfInvoiceViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier, for: indexPath) as? InvoiceDeliveryMethodsTableViewCell
        guard let tableCell = cell,
              let deliveryOfInvoiceViewModel = deliveryOfInvoiceViewModel else { return UITableViewCell() }
        
        let cellViewModel = deliveryOfInvoiceViewModel.cellViewModel(for: indexPath)
        tableCell.viewModel = cellViewModel
        tableCell.accessoryType = cellViewModel.selected ? .checkmark : .none
        
        return tableCell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension InvoiceDeliveryMethodsViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return InvoiceDeliveryMethodsTableViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func skeletonShow1() {
        // skeletonView
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.25))
    }
    
    func skeletonStop() {
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}
