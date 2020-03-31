//
//  DevileryOfInvoiceTVController.swift
//  mpges.lk
//
//  Created by Timur on 22.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class DeliveryOfInvoiceTVController: UITableViewController {
        
    override func viewDidLoad() {
        self.title = "Доставка квитанций"
        super.viewDidLoad()
        configuration()
        ActivityIndicatorViewService.shared.hideView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.didFinishPage()
    }
    public weak var delegate: DeliveryOfInvoiceTVControllerDelegate?
    
    // MARK: - Table view data source
    var deliveryOfTypeList = [DeliveryOfInvoiceModel]() {
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
        deliveryOfTypeList[indexPath.row].selected = !deliveryOfTypeList[indexPath.row].selected
        let selected = deliveryOfTypeList[indexPath.row]
        var temp = [DeliveryOfInvoiceModel]()
        for var item in deliveryOfTypeList {
            if (item.id != selected.id) { item.selected = false }
            temp.append(item)
        }
        deliveryOfTypeList = temp
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deliveryOfTypeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryOfInvoiceCell", for: indexPath)
        cell.textLabel?.text = deliveryOfTypeList[indexPath.row].devileryMethodName
        cell.imageView?.image = UIImage(systemName: myImage.mail.rawValue)
        cell.accessoryType = .none
        if (deliveryOfTypeList[indexPath.row].selected) { cell.accessoryType = .checkmark }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension DeliveryOfInvoiceTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "DeliveryOfInvoiceTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "deliveryOfInvoiceCell")
        self.tableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}
