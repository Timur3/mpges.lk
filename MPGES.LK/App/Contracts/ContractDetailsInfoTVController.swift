//
//  ContractDetailsInfoTVC.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PassKit

protocol ContractDetailsInfoTVControllerDelegate: class {
    func navigateToBackPage()
    func navigateToPaymentsPage()
    func navigationToInvoicePage()
    func navigationDevicesPage()
    func navigationInvoiceDevileryMethodPage(for contract: ContractModel, delegate: ContractDetailsInfoTVControllerUserDelegate)
    func navigationToContractorInfoPage()
    func navigateToPayWithCreditCardPage()
    func navigateToPayWithSberbankOnlinePage()
}

class ContractDetailsInfoTVController: CommonTableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerDelegate?
    
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.mpges.lk"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["RU"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Потребленная электроэнергия", amount: 1.00)]
        return request
    }()
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "Лицевой счет:", imageCell: myImage.tag, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractDateCell: UITableViewCell = { getCustomCell(textLabel: "Дата договора:", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var contractorCell: UITableViewCell = { getCustomCell(textLabel: "Контрагент:", imageCell: myImage.person, textAlign: .left, accessoryType: .detailButton) }()
    
    // Отображение баланса
    var contractSaldoCell: UITableViewCell = { getCustomCell(textLabel: "Баланс:", imageCell: myImage.rub, textAlign: .left, accessoryType: .none, isUserInteractionEnabled: false) }()
    var saldoSumLabel: UILabel = { getCustomForContractLabel(text: "0.00") }()
    var contractorLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var contractDateLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    var accountLabel: UILabel = { getCustomForContractLabel(text: "...") }()
    //--
    
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Пополнить счет", imageCell: myImage.creditcard, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "История платежей", imageCell: myImage.rub, textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "История начислений", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", imageCell: myImage.link, textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: (contractModel?.invoiceDeliveryMethod.devileryMethodName ?? "..."), imageCell: myImage.mail, textAlign: .left, accessoryType: .disclosureIndicator)}
    
    public var contractModel: ContractModel? {
        didSet {
            DispatchQueue.main.async {
                self.accountLabel.text = self.contractModel!.number
                self.contractDateLabel.text = self.contractModel!.dateRegister
                self.contractorLabel.text = self.contractModel!.contractor.nameSmall
                ApiServiceWrapper.shared.loadSaldoContract(id: self.contractModel!.id, label: self.saldoSumLabel)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Лицевой счет"
        super.viewDidLoad()
        setUpLayout()
        Configuration()
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
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            self.delegate?.navigationToContractorInfoPage()
        }
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
                return accountCell
            case 1:
                return contractDateCell
            case 2:
                return contractorCell
            case 3:
                return contractSaldoCell
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
        self.indexPath = indexPath
        if indexPath.section == 0 && indexPath.row == 2 {
            self.delegate?.navigationToContractorInfoPage()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            alertSheetShow()
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
    
    var sections: [String] { ["Основная информация", "Оплата",  "История платежей, начислений и приборы учета", "Доставка квитанций"] }
    
    func setContractById(contract: ContractModel) {
        contractModel = contract
        self.refreshControl?.endRefreshing()
    }
}

extension ContractDetailsInfoTVController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CONFIGURE
extension ContractDetailsInfoTVController {
    
    func alertSheetShow() {
        let alert = UIAlertController(title: "Выбор способа оплаты:", message: nil, preferredStyle: .actionSheet)
        let actionApplePay = UIAlertAction(title: "Apple Pay", style: .default) {
            (UIAlertAction) in self.purchase()
        }
        //let actionOthersBank = UIAlertAction(title: "Банковские карты", style: .default) {//
        //  (UIAlertAction) in self.delegate?.navigateToPayWithCreditCardPage()
        //}
        let actionSberBank = UIAlertAction(title: "Сбербанк Онлайн", style: .default) {
            (UIAlertAction) in
            //self.goToSberbankOnline()
            self.delegate?.navigateToPayWithSberbankOnlinePage()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        // alert.addAction(actionApplePay)
        // alert.addAction(actionOthersBank)
        alert.addAction(actionSberBank)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func goToSberbankOnline(){
        let url = URL(string: "sberbankonline://payments/services/init/?ids=eyJjbiI6eyJiIjoiMjg0IiwibiI6ItCt0LvQtdC60YLRgNC-0Y3QvdC10YDQs9C40Y8iLCJwcyI6IjU1MDY5Njc5NSJ9LCJucyI6eyJub2RlMC5vbmxpbmUuc2JlcmJhbmsucnUiOnsicHMiOiI1MDA2NjQyMDcifSwibm9kZTEub25saW5lLnNiZXJiYW5rLnJ1Ijp7InBzIjoiODQ3NTI1In0sIm5vZGUyLm9ubGluZS5zYmVyYmFuay5ydSI6eyJwcyI6IjUwMDY2NDY5MSJ9LCJub2RlMy5vbmxpbmUuc2JlcmJhbmsucnUiOnsicHMiOiI1MDA2NjQxMDgifSwibm9kZTQub25saW5lLnNiZXJiYW5rLnJ1Ijp7InBzIjoiNTAwNjU4MzkzIn0sIm5vZGU1Lm9ubGluZS5zYmVyYmFuay5ydSI6eyJwcyI6IjUwMDY1ODQ2MyJ9fSwiYXQiOmZhbHNlfQ")
        
        UIApplication.shared.open(url!) { (result) in
            if result {
                // The URL was delivered successfully!
            }
        }
        //let strURL = "sberbankonline://payments/"
        //let url = URL.init(string: strURL)
        //if (UIApplication.shared.canOpenURL(url!)){
        //    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        //}
    }
    func purchase() {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
    private func Configuration() {
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
