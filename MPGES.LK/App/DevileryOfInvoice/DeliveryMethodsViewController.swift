//
//  DeliveryMethodsViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.02.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit
import SkeletonView

public protocol DeliveryMethodTVControllerDelegate: class {
    func setData(for deliveryMethod: ResultModel<[InvoiceDeliveryMethodModel]>)
    func resultOfUpdateDeliveryMethod(for resultModel: ResultModel<String>)
}


class DeliveryMethodsViewController: UIViewController, SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    public weak var delegate: ContractDetailsInfoTVControllerUserDelegate?
    public var contract: ContractModel?
    public var selectedDeliveryMethod: InvoiceDeliveryMethodModel?
    lazy var tableView = UITableView.init(frame: .zero, style: .insetGrouped)
    private var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Доставка квитанций"
        setUpLayout()
        configuration()
        getData()
    }
    
    func configuration(){
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "DeliveryOfInvoiceTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: DeliveryOfInvoiceTableViewCell.identifier)
        //self.tableView.register(DeliveryHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerTable")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // skeletonView
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.25))
    }
    
    func setUpLayout(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return DeliveryOfInvoiceTableViewCell.identifier
    }
           
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContractById(id: contract!.id)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ApiServiceWrapper.shared.getDeliveryOfInvoices(delegate: self)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
        let updDeliveryMethod = UpdateDeliveryMethodModel(contractId: contract!.id, deliveryMethodId: selectedDeliveryMethod!.id)
        ApiServiceWrapper.shared.updateDeliveryMethod(model: updDeliveryMethod, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deliveryMethodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOfInvoiceTableViewCell.identifier, for: indexPath) as! DeliveryOfInvoiceTableViewCell
        cell.update(for: deliveryMethodList[indexPath.row].devileryMethodName)
        cell.accessoryType = .none
        if (deliveryMethodList[indexPath.row].selected) { cell.accessoryType = .checkmark }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension DeliveryMethodsViewController: DeliveryMethodTVControllerDelegate {
    
    func resultOfUpdateDeliveryMethod(for resultModel: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = resultModel.isError
        self.showAlert(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: resultModel.message!) { (UIAlertAction) in
            if !isError {
                //self.cancelButton()
            }
        }
    }
    
    func setData(for deliveryMethod: ResultModel<[InvoiceDeliveryMethodModel]>) {
        var temp = [InvoiceDeliveryMethodModel]()
        for var item in deliveryMethod.data! {
            if (item.id == self.contract?.invoiceDeliveryMethodId) {
                item.selected = true
                selectedDeliveryMethod = item
            }
            temp.append(item)
        }
        deliveryMethodList = temp
        setUpLayout()
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}

