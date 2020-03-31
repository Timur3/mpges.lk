//
//  ContractDetailsInfoTVC.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ContractDetailsInfoTVControllerDelegate: class {
    func navigateToBackPage()
    func navigateToPaymentsPage()
    func navigationToInvoicePage()
    func navigationDevicesPage()
    func navigationDevileryOfInvoicePage()
}

class ContractDetailsInfoTVController: UITableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerDelegate?
    
    var contractNumber: UITableViewCell { getCustomCell(textLabel: "Лицевой счет: " + (contractModel?.number ?? "..."), imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }
    var contractDate: UITableViewCell { getCustomCell(textLabel: "Дата договора: " + (contractModel?.dateRegister ?? "..."), imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }
    var contractor: UITableViewCell { getCustomCell(textLabel: "Контрагент: " + (contractModel?.contractorNameSmall ?? "..."), imageCell: myImage.person, textAlign: .left, accessoryType: .none) }
    var contractSaldo: UITableViewCell { getCustomCell(textLabel: "Баланс: " + ("загружаю..."), imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Пополнить счет", imageCell: myImage.creditcard, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "История платежей", imageCell: myImage.rub, textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "История начислений", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    //var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "Реестр квитанций", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", imageCell: myImage.link, textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: "Доставка квитанций", imageCell: myImage.mail, textAlign: .left, accessoryType: .disclosureIndicator)}
    
    var contractModel: ContractModel? {
             didSet {
                 DispatchQueue.main.async {
                    self.contractNumber.textLabel?.text = "Лицевой счет: " + self.contractModel!.number
                    self.contractDate.textLabel?.text = self.contractModel!.dateRegister
                    self.contractor.textLabel?.text = self.contractModel!.contractorNameSmall
                    //ApiServiceAdapter.shared.loadSaldoContract(id: (self.contractModel!.id), label: self.contractSaldo.textLabel!)
                   self.tableView.reloadData()
                 }
             }
         }
    
    override func viewDidLoad() {
        navigationItem.title = "Лицевой счет"
        super.viewDidLoad()
        Configuration()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 1
        default:
            fatalError()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return contractNumber
            case 1:
                return contractDate
            case 2:
                return contractor
            case 3:
                return contractSaldo
            case 4:
                return makeAPayment
            default:
                fatalError()
            }
        case 1:
        switch indexPath.row {
        case 0:
            return makeAPayment
        default:
            fatalError()
        }
        case 2:
            switch indexPath.row {
            case 0:
                return calculationsOfContract
            case 1:
                return paymentsOfContract
            case 2:
                return devicesOfContract
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return mailOfContract
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {
            
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            alertSheetShow()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.delegate?.navigationToInvoicePage()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            ActivityIndicatorViewService.shared.showView(form: self.view)
            self.delegate?.navigateToPaymentsPage()
        }
        
        if indexPath.section == 2 && indexPath.row == 2 {
            self.delegate?.navigationDevicesPage()
        }
        
        if indexPath.section == 3 && indexPath.row == 0 {
            ActivityIndicatorViewService.shared.showView(form: self.view)
            self.delegate?.navigationDevileryOfInvoicePage()
        }
    }
}

extension ContractDetailsInfoTVController: ContractDetailsInfoTVControllerUserDelegate {
    var sections: [String] { ["Основная информация", "Оплата",  "История платежей, начислений и приборы учета", "Доставка квитанций"] }
    
    func setContractById(contract: ContractModel) {
        contractModel = contract
    }
}

//MARK: - CONFIGURE
extension ContractDetailsInfoTVController {
    func alertSheetShow() {
        let alert = UIAlertController(title: "Выбор способа оплаты:", message: nil, preferredStyle: .actionSheet)
        let actionApplePay = UIAlertAction(title: "Apple Pay", style: .default, handler: nil)
        let actionBank = UIAlertAction(title: "Банковские карты", style: .default, handler: nil)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionApplePay)
        alert.addAction(actionBank)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    private func Configuration() {
        self.refreshControl = UIRefreshControl()
        definesPresentationContext = true
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ContractsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "contractCell")
        self.tableView.dataSource = self
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        //refreshDataContract(sender: self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    @objc func refreshData() {
        
        self.refreshControl?.endRefreshing()
    }
}
