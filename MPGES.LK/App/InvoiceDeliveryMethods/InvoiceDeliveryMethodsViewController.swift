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

class InvoiceDeliveryMethodsViewController: CommonViewController {
    
    weak var delegate: ContractDetailsInfoTVControllerUserDelegate?
    private var selectedDeliveryMethod: InvoiceDeliveryMethodModel?
    
    private lazy var InvoiceDeliveryMethodsTable: UITableView = {
        var table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(InvoiceDeliveryMethodsTableViewCell.self, forCellReuseIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var deliveryMethodList = [InvoiceDeliveryMethodModel]() {
        didSet {
            DispatchQueue.main.async {
                self.InvoiceDeliveryMethodsTable.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    
    private var indexPath: IndexPath?
    var contract: ContractModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Доставка квитанций"
        setUpLayout()
        getData()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContractById(id: contract!.id)
    }
    
    func getData() {
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ApiServiceWrapper.shared.getDeliveryOfInvoices(delegate: self)
        }
    }
}
// MARK: - Table view data source
extension InvoiceDeliveryMethodsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            tableView.deselectRow(at: indexPath, animated: true)
            self.indexPath = indexPath
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
    }
    
    func sendDeliveryMethod() {
        let updDeliveryMethod = UpdateDeliveryMethodModel(contractId: contract!.id, deliveryMethodId: selectedDeliveryMethod!.id)
        ApiServiceWrapper.shared.updateDeliveryMethod(model: updDeliveryMethod, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryMethodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceDeliveryMethodsTableViewCell.identifier, for: indexPath) as! InvoiceDeliveryMethodsTableViewCell
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
        return false
    }
}

// MARK: - InvoiceDeliveryMethodTVControllerDelegate
extension InvoiceDeliveryMethodsViewController: InvoiceDeliveryMethodTVControllerDelegate {
    
    func resultOfUpdateDeliveryMethod(for resultModel: ResultModel<String>) {
        let isError = resultModel.isError
        if isError {
            self.showAlert(title: "Ошибка", mesg: resultModel.message!)
        } else {
            self.showToast(message: "Успешно")
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
