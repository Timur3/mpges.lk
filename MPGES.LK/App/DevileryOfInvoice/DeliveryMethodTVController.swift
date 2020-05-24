//
//  DevileryOfInvoiceTVController.swift
//  mpges.lk
//
//  Created by Timur on 22.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol DeliveryMethodTVControllerDelegate: class {
    func setData(for deliveryMethod: InvoiceDeliveryMethodModelRoot)
    func resultOfUpdateDeliveryMethod(for resultModel: ServerResponseModel)
}

class DeliveryMethodTVController: CommonTableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerUserDelegate?
    public var contract: ContractModel?
    public var selectedDeliveryMethod: InvoiceDeliveryMethodModel?
    
    override func viewDidLoad() {
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        self.title = "Доставка квитанций"
        super.viewDidLoad()
        configuration()
        getData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContractById(id: contract!.id)
    }
    
    func getData() {
        ApiServiceWrapper.shared.getDeliveryOfInvoices(delegate: self)
    }
    
    // MARK: - Table view data source
    var deliveryMethodList = [InvoiceDeliveryMethodModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Способы доставки квитанций"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        //ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: indexPath)!)
        let updDeliveryMethod = UpdateDeliveryMethodModel(contractId: contract!.id, deliveryMethodId: selectedDeliveryMethod!.id)
        ApiServiceWrapper.shared.updateDeliveryMethod(model: updDeliveryMethod, delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deliveryMethodList.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryOfInvoiceCell", for: indexPath)
        cell.textLabel?.text = deliveryMethodList[indexPath.row].devileryMethodName
        cell.imageView?.image = UIImage(systemName: myImage.mail.rawValue)
        cell.accessoryType = .none
        if (deliveryMethodList[indexPath.row].selected) { cell.accessoryType = .checkmark }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension DeliveryMethodTVController: DeliveryMethodTVControllerDelegate {
    
    func resultOfUpdateDeliveryMethod(for resultModel: ServerResponseModel) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = resultModel.isError
        AlertControllerAdapter.shared.show(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: resultModel.message,
            form: self) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
                }
        }
        //self.hiddenAI()
        ActivityIndicatorViewService.shared.hideView()
    }
    
    func setData(for deliveryMethod: InvoiceDeliveryMethodModelRoot) {
        var temp = [InvoiceDeliveryMethodModel]()
        for var item in deliveryMethod.data {
            if (item.id == self.contract?.invoiceDeliveryMethodId) {
                item.selected = true
                selectedDeliveryMethod = item
            }
            temp.append(item)
        }
        deliveryMethodList = temp
        ActivityIndicatorViewService.shared.hideView()
    }
}

extension DeliveryMethodTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "DeliveryOfInvoiceTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "deliveryOfInvoiceCell")
        self.tableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}
