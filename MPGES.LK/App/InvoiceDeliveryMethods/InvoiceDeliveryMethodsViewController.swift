//
//  InvoiceDeliveryMethodsViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol InvoiceDeliveryMethodTVControllerDelegate: AnyObject {
    func setData(for deliveryMethod: ResultModel<[InvoiceDeliveryMethodModel]>)
    func resultOfUpdateDeliveryMethod(for resultModel: ResultModel<String>)
}

class InvoiceDeliveryMethodsViewController: UIViewController, UITableViewDataSource {
    
    weak var delegate: ContractDetailsInfoTVControllerUserDelegate?
    private var selectedDeliveryMethod: InvoiceDeliveryMethodModel?
    
    private lazy var InvoiceDeliveryMethodsTable: UITableView = {
        var table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(InvoiceDeliveryMethodsTableViewCell.self, forCellReuseIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var deliveryMethodList = [InvoiceDeliveryMethodModel]() {
        didSet {
            DispatchQueue.main.async {
                self.InvoiceDeliveryMethodsTable.reloadData()
            }
        }
    }
    
    private var indexPath: IndexPath?
    var contract: ContractModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Доставка квитанций"
        getData()
        setUpLayout()
        //bindingData()
    }
    
    func setUpLayout(){
        view.addSubview(InvoiceDeliveryMethodsTable)
        NSLayoutConstraint.activate([
            InvoiceDeliveryMethodsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            InvoiceDeliveryMethodsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            InvoiceDeliveryMethodsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            InvoiceDeliveryMethodsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func bindingData() {
        //deliveryOfInvoiceViewModel = DeliveryOfInvoiceViewModel()
       /* guard let data = deliveryOfInvoiceViewModel?.deliveryOfInvoices else { return }
        var temp = [InvoiceDeliveryMethodModel]()
        for var item in data {
            if (item.id == self.contract?.invoiceDeliveryMethodId) {
                item.selected = true
                selectedDeliveryMethod = item
            }
            temp.append(item)
        }
        deliveryMethodList = temp*/
        setUpLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContractById(id: contract!.id)
    }
    
    func getData() {
        DispatchQueue.main.async {
            ApiServiceWrapper.shared.getDeliveryOfInvoices(delegate: self)
        }
    }
    
    // MARK: - Table view data source
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        //ActivityIndicatorViewForCellService.shared.showAI(cell: self.InvoiceDeliveryMethodsTable.cellForRow(at: indexPath)!)
        
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
        ApiServiceWrapper.shared.updateDeliveryMethod(model: updDeliveryMethod, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deliveryMethodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier, for: indexPath) as! InvoiceDeliveryMethodsTableViewCell
        //guard let tableCell = cell,
         //     let deliveryOfInvoiceViewModel = deliveryOfInvoiceViewModel else { return UITableViewCell() }
        
        //let cellViewModel = deliveryOfInvoiceViewModel.cellViewModel(for: indexPath)
        //tableCell.viewModel = cellViewModel
        //tableCell.accessoryType = cellViewModel.selected ? .checkmark : .none
        cell.update(deliveryMethodList[indexPath.row])
        cell.accessoryType = deliveryMethodList[indexPath.row].selected ? .checkmark : .none
        return cell
    }
}

//MARK: - UITableViewDelegate
extension InvoiceDeliveryMethodsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Способы доставки квитанций"
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

// MARK: - InvoiceDeliveryMethodTVControllerDelegate
extension InvoiceDeliveryMethodsViewController: InvoiceDeliveryMethodTVControllerDelegate {
    
    func resultOfUpdateDeliveryMethod(for resultModel: ResultModel<String>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let isError = resultModel.isError
            self.showAlert(
                title: isError ? "Ошибка!" : "Успешно!",
                mesg: resultModel.message!) { (UIAlertAction) in
                    if !isError {
                        //self.cancelButton()
                    }
                }
            //ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.InvoiceDeliveryMethodsTable.cellForRow(at: self.indexPath!)!)
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
    }
}
