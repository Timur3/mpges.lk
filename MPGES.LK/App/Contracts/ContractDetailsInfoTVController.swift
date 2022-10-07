//
//  ContractDetailsInfoTVC.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import TinkoffASDKCore
import TinkoffASDKUI

protocol ContractDetailsInfoTVControllerDelegate: AnyObject {
    func navigateToBackPage()
    func navigateToPaymentsPage()
    func navigationToInvoicePage()
    func navigationDevicesPage()
    func navigationInvoiceDevileryMethodPage(for contract: ContractModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigationToContractorInfoPage(for contractor: ContractorModel)
    func navigateToPayWithCreditCardPage()
    func navigateToPayWithSberbankOnlinePage(model: BankPayModel)
    func navigateToPayWithApplePayPage(model: BankPayModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigateToPayWithTinkoffPage(model: BankPayModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigationToResultOfPayment(for model: ResultModel<Double>)
}

class ContractDetailsInfoTVController: CommonTableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerDelegate?
    public var contractId: Int = 0
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "Лицевой счет:", imageCell: myImage.tag, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractNumberCell: UITableViewCell = { getCustomCell(textLabel: "Номер:", imageCell: myImage.docText, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractDateCell: UITableViewCell = { getCustomCell(textLabel: "Дата:", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractorCell: UITableViewCell = { getCustomCell(textLabel: "Контрагент:", imageCell: myImage.person, textAlign: .left, accessoryType: .disclosureIndicator) }()
    
    // Отображение баланса
    var contractSaldoCell: UITableViewCell = { getCustomCell(textLabel: "Баланс:", imageCell: myImage.rub, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var saldoSumLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractorLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractNumberLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractDateLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var accountLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    //--
    
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Оплатить", imageCell: myImage.creditcard, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "Платежи", imageCell: myImage.rub, textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "Начисления", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", imageCell: myImage.gauge, textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: (contractModel?.invoiceDeliveryMethod.devileryMethodName ?? "..."), imageCell: myImage.none, textAlign: .left, accessoryType: .disclosureIndicator, customImage: getImage(contractModel?.invoiceDeliveryMethodId ?? 0))}
    
    public var contractModel: ContractModel? {
        didSet {
            DispatchQueue.main.async {
                guard let contractModel = self.contractModel else { return }
                self.contractNumberLabel.text = "\(contractModel.id)"
                self.accountLabel.text = contractModel.number
                self.contractDateLabel.text = contractModel.dateRegister
                self.contractorLabel.text = ("\(contractModel.contractor.name) \(contractModel.contractor.middleName?.prefix(1) ?? "_"). \(contractModel.contractor.family.prefix(1)).")
                ApiServiceWrapper.shared.getContractStatus(id: contractModel.id, delegate: self)
                self.tableView.reloadData()
                //self.hideLoadingIndicator()
            }
        }
    }
    public var contractStatusInfoModel: ContractStatusModel? {
        didSet {
            DispatchQueue.main.async {
                self.contractSaldoCell.textLabel?.text = self.contractStatusInfoModel?.statusName
                self.saldoSumLabel.text = formatRusCurrency(self.contractStatusInfoModel!.value)
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Договор"
        super.viewDidLoad()
        self.showLoadingIndicator()
        setUpLayout()
        configuration()
        refreshContract()
    }
    
    func setUpLayout(){
        let inset: CGFloat = 50
        contractSaldoCell.contentView.addSubview(saldoSumLabel)
        saldoSumLabel.rightAnchor.constraint(equalTo: contractSaldoCell.rightAnchor, constant: -inset).isActive = true
        saldoSumLabel.centerYAnchor.constraint(equalTo: contractSaldoCell.centerYAnchor).isActive = true
        contractorCell.contentView.addSubview(contractorLabel)
        contractorLabel.rightAnchor.constraint(equalTo: contractorCell.rightAnchor, constant: -inset).isActive = true
        contractorLabel.centerYAnchor.constraint(equalTo: contractorCell.centerYAnchor).isActive = true
        contractDateCell.contentView.addSubview(contractDateLabel)
        contractDateLabel.rightAnchor.constraint(equalTo: contractDateCell.rightAnchor, constant: -inset).isActive = true
        contractDateLabel.centerYAnchor.constraint(equalTo: contractDateCell.centerYAnchor).isActive = true
        accountCell.contentView.addSubview(accountLabel)
        accountLabel.rightAnchor.constraint(equalTo: accountCell.rightAnchor, constant: -inset).isActive = true
        accountLabel.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        contractNumberCell.contentView.addSubview(contractNumberLabel)
        contractNumberLabel.rightAnchor.constraint(equalTo: contractNumberCell.rightAnchor, constant: -inset).isActive = true
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
    
    func setContractStatus(for model: ResultModel<ContractStatusModel>) {
        contractStatusInfoModel = model.data
    }
    
    func getContractById(id: Int) {
        ApiServiceWrapper.shared.getContractById(id: id, delegate: self)
    }
    
    var sections: [String?] { ["Основная информация", "Состояние лицевого счета", "", "Доставка квитанций"] }
    
    func setContractById(for contract: ResultModel<ContractModel>) {
        contractModel = contract.data
        self.refreshControl?.endRefreshing()
    }
    
    func getStatePayment(for model: RequestOfPayModel) {
        ApiServiceWrapper.shared.getStateApplePay(model: model, delegate: self.delegate!)
    }
}

//MARK: - CONFIGURE
extension ContractDetailsInfoTVController {
    
    func alertSheetMethodPayShow() {
        let alertController = UIAlertController(title: "Выбор способа оплаты:", message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        let actionApplePay = UIAlertAction(title: "Apple Pay", style: .default) {
            (UIAlertAction) in
            self.goToApplePayPage()
        }
        let appleLogoImage = UIImage(systemName: myImage.appleLogo.rawValue)
        
        if let icon = appleLogoImage?.imageWithSize(scaledToSize: CGSize(width: 29, height: 32)) {
            actionApplePay.setValue(icon, forKey: "image")
        }
        
        let actionSberBank = UIAlertAction(title: "Сбербанк Онлайн", style: .default) {
            (UIAlertAction) in
            self.goToSberbankOnlinePage()
        }
        let sberLogoImage = UIImage(named: myImage.sberLogo.rawValue)
        if let icon = sberLogoImage?.imageWithSize(scaledToSize: CGSize(width: 29, height: 29)) {
            actionSberBank.setValue(icon, forKey: "image")
        }
        
        let actionOthersBank = UIAlertAction(title: "Оплата картой", style: .default) {
            (UIAlertAction) in
            self.paymentOthersBank()
        }
        
        /*let bankLogoImage = UIImage(systemName: "creditcard")
         if let icon = bankLogoImage?.imageWithSize(scaledToSize: CGSize(width: 29, height: 29)) {
         actionOthersBank.setValue(icon, forKey: "image")
         }*/
        
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(actionApplePay)
        alertController.addAction(actionSberBank)
        alertController.addAction(actionOthersBank)
        alertController.addAction(actionCancel)
        
        if UIDevice.isPad {
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.tableView
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = [];
            }
        }
        self.present(alertController, animated: true, completion: {
            print("completion block")
        })
    }
    
    func goToApplePayPage() {
        let model = getBankPayModel()
        self.delegate?.navigateToPayWithApplePayPage(model: model, delegate: self)
    }
    
    func paymentOthersBank() {
        let model = getBankPayModel()
        self.delegate?.navigateToPayWithTinkoffPage(model: model, delegate: self)
        //self.delegate?.navigateToPayWithCreditCardPage()
    }
    
    func goToSberbankOnlinePage()
    {
        let model = getBankPayModel()
        self.delegate?.navigateToPayWithSberbankOnlinePage(model: model)
    }
    
    private func getBankPayModel() -> BankPayModel {
        var sum = self.saldoSumLabel.text
        if (self.contractStatusInfoModel?.id == 2) {
            sum = formatRusCurrency(0.00)
        }
        return BankPayModel(
            contractId: self.contractModel!.id, contractNumber: self.contractModel!.number, emailOrMobile: UserDataService.shared.getEmail() ?? "", summa: sum!)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getContractById(id: self.contractId)
        }
    }
}

