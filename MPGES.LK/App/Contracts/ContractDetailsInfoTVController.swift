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
    func navigationInvoiceDevileryMethodPage(for contract: ContractModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigationToContractorInfoPage(for contractor: ContractorModel)
    func navigateToPayWithCreditCardPage()
    func navigateToPayWithSberbankOnlinePage(model: BankPayModel)
    func navigateToPayWithApplePayPage(model: BankPayModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigationToResultOfPayment(for model: ResultModel<Decimal>)
}

class ContractDetailsInfoTVController: CommonTableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerDelegate?
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "Лицевой счет:", imageCell: myImage.tag, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractNumberCell: UITableViewCell = { getCustomCell(textLabel: "Номер:", imageCell: myImage.docText, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractDateCell: UITableViewCell = { getCustomCell(textLabel: "Дата:", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractorCell: UITableViewCell = { getCustomCell(textLabel: "Контрагент:", imageCell: myImage.person, textAlign: .left, accessoryType: .disclosureIndicator) }()
    
    // Отображение баланса
    var contractSaldoCell: UITableViewCell = { getCustomCell(textLabel: "Баланс:", imageCell: myImage.rub, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var saldoSumLabel: UILabel = { getCustomForContractLabel(text: "0.00") }()
    var contractorLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractNumberLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractDateLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var accountLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    //--
    
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Оплатить", imageCell: myImage.creditcard, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "Платежи", imageCell: myImage.rub, textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "Начисления", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", imageCell: myImage.gauge, textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: (contractModel?.invoiceDeliveryMethod.devileryMethodName ?? "..."), imageCell: myImage.mail, textAlign: .left, accessoryType: .disclosureIndicator)}
    
    public var contractModel: ContractModel? {
        didSet {
            DispatchQueue.main.async {
                self.contractNumberLabel.text = "\(self.contractModel!.id)"
                self.accountLabel.text = self.contractModel!.number
                self.contractDateLabel.text = self.contractModel!.dateRegister
                self.contractorLabel.text = self.contractModel!.contractor.name + " " + self.contractModel!.contractor.middleName!.prefix(1) + ". " + self.contractModel!.contractor.family.prefix(1) + "."
                ApiServiceWrapper.shared.getContractStatus(id: self.contractModel!.id, status: self.contractSaldoCell, value: self.saldoSumLabel)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Договор"
        super.viewDidLoad()
        setUpLayout()
        configuration()
    }
    
    func setUpLayout(){
        contractSaldoCell.addSubview(saldoSumLabel)
        saldoSumLabel.rightAnchor.constraint(equalTo: contractSaldoCell.rightAnchor, constant: -50).isActive = true
        saldoSumLabel.centerYAnchor.constraint(equalTo: contractSaldoCell.centerYAnchor).isActive = true
        contractorCell.addSubview(contractorLabel)
        contractorLabel.rightAnchor.constraint(equalTo: contractorCell.rightAnchor, constant: -50).isActive = true
        contractorLabel.centerYAnchor.constraint(equalTo: contractorCell.centerYAnchor).isActive = true
        contractDateCell.addSubview(contractDateLabel)
        contractDateLabel.rightAnchor.constraint(equalTo: contractDateCell.rightAnchor, constant: -50).isActive = true
        contractDateLabel.centerYAnchor.constraint(equalTo: contractDateCell.centerYAnchor).isActive = true
        accountCell.addSubview(accountLabel)
        accountLabel.rightAnchor.constraint(equalTo: accountCell.rightAnchor, constant: -50).isActive = true
        accountLabel.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        contractNumberCell.addSubview(contractNumberLabel)
        contractNumberLabel.rightAnchor.constraint(equalTo: contractNumberCell.rightAnchor, constant: -50).isActive = true
        contractNumberLabel.centerYAnchor.constraint(equalTo: contractNumberCell.centerYAnchor).isActive = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            
           /* if !(saldoSumLabel.text!.isEmpty) {
                let amount = self.saldoSumLabel.text!.removeFormatAndSpace()
                if amount >= 0.00 {
                    self.contractSaldoCell.textLabel?.text = "Задолженность:"
                    self.saldoSumLabel.layer.backgroundColor = UIColor.systemRed.cgColor
                    self.contractSaldoCell.layer.borderColor = UIColor.systemRed.cgColor
                } else
                {
                    self.contractSaldoCell.textLabel?.text = "Переплата:"
                    self.saldoSumLabel.layer.backgroundColor = UIColor.systemGreen.cgColor
                    self.contractSaldoCell.layer.borderColor = UIColor.systemGreen.cgColor
                }
                self.contractSaldoCell.layer.borderWidth = 1.0
            }*/
            //cell.layer.backgroundColor = UIColor.systemGreen.cgColor
            //cell.layer.borderColor = UIColor.white.cgColor
            //cell.layer.borderWidth = 1.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 2 {
            self.delegate?.navigationToContractorInfoPage(for: contractModel!.contractor)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 2
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
                return contractNumberCell
            case 1:
                return contractDateCell
            case 2:
                return accountCell
            case 3:
                return contractorCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return contractSaldoCell
            case 1:
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
        self.indexPath = indexPath
        if indexPath.section == 0 && indexPath.row == 0 {
        }
        if indexPath.section == 0 && indexPath.row == 3 {
            self.delegate?.navigationToContractorInfoPage(for: self.contractModel!.contractor)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            alertSheetMethodPayShow()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.delegate?.navigationToInvoicePage()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            self.delegate?.navigateToPaymentsPage()
        }
        
        if indexPath.section == 2 && indexPath.row == 2 {
            self.delegate?.navigationDevicesPage()
        }
        
        if indexPath.section == 3 && indexPath.row == 0 {
            self.delegate?.navigationInvoiceDevileryMethodPage(for: contractModel!, delegate: self)
        }
    }
}

extension ContractDetailsInfoTVController: ContractDetailsInfoTVControllerUserDelegate {
   
    func getContractById(id: Int) {
        ApiServiceWrapper.shared.getContractById(id: id, delegate: self)
    }
    
    var sections: [String?] { ["Основная информация", "Состояние лицевого счета", "", "Доставка квитанций"] }
    
    func setContractById(contract: ResultModel<ContractModel>) {
        contractModel = contract.data
        self.refreshControl?.endRefreshing()
    }
    
    func getStatePayment(for model: RequestOfPayModel) {
        ActivityIndicationService.shared.showView(form: self.view)
        ApiServiceWrapper.shared.getStateApplePay(model: model, delegate: self.delegate!)
    }
}

//MARK: - CONFIGURE
extension ContractDetailsInfoTVController {
    
    func alertSheetMethodPayShow() {
        let alert = UIAlertController(title: "Выбор способа оплаты:", message: nil, preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover
        let actionApplePay = UIAlertAction(title: "Apple Pay", style: .default) {
            (UIAlertAction) in
            self.goToApplePayPage()
        }
        //let actionOthersBank = UIAlertAction(title: "Банковские карты", style: .default) {//
        //  (UIAlertAction) in self.delegate?.navigateToPayWithCreditCardPage()
        //}
        let actionSberBank = UIAlertAction(title: "Сбербанк Онлайн", style: .default) {
            (UIAlertAction) in
            self.goToSberbankOnlinePage()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionApplePay)
        // alert.addAction(actionOthersBank)
        alert.addAction(actionSberBank)
        alert.addAction(actionCancel)
        
        if UIDevice.isPad {
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.tableView
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [];
          }
        }
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func goToApplePayPage() {
        let model = BankPayModel(contractId: self.contractModel!.id, contractNumber: self.contractModel!.number, emailOrMobile: UserDataService.shared.getKey(keyName: "email") ?? "", summa: self.saldoSumLabel.text!)
        self.delegate?.navigateToPayWithApplePayPage(model: model, delegate: self)
    }
    
    func goToSberbankOnlinePage()
    {
        let model = BankPayModel(
            contractId: self.contractModel!.id, contractNumber: self.contractModel!.number, emailOrMobile: UserDataService.shared.getKey(keyName: "email") ?? "", summa: self.saldoSumLabel.text!)
        self.delegate?.navigateToPayWithSberbankOnlinePage(model: model)
    }
    
    private func configuration() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshContract), for: UIControl.Event.valueChanged)
        
        definesPresentationContext = true
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ContractsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "contractCell")
        self.tableView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    @objc func refreshContract() {
        getContractById(id: contractModel!.id)
    }
}

