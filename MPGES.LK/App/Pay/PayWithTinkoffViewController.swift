//
//  PayWithTinkoffViewController.swift
//  mpges.lk
//
//  Created by Timur on 06.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit
import PassKit
import Alamofire
import TinkoffASDKUI
import TinkoffASDKCore

class PayWithTinkoffViewController: CommonTableViewController {
    var sdk: AcquiringUISDK!
    
    public weak var contractDelegate: ContractDetailsInfoTVControllerUserDelegate?
    
    var sections: [String] {["Лицевой счет", "Сумма к оплате", "Доставка электронного чека", ""]}
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }()
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    
    private lazy var buttonPayCell: ButtonPayTableViewCell = {
        var cell = ButtonPayTableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .systemGroupedBackground
        cell.button.setTitleColor(UIColor.label, for: .normal)
        cell.onButtonTouch = {
            self.payButtonTap()
            print(#function)
        }
        return cell
    }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "", keyboardType: .decimalPad) }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var summaTextField: UITextField = { getCustomTextField(placeholder: "", keyboardType: .decimalPad) }()
    
    var response: ResultModel<String>?
    var paymentId: Int = 0
    var requestModel: RequestOfPayModel?
    var model: BankPayModel? {
        didSet {
            DispatchQueue.main.async {
                self.contactTextField.text = self.model?.emailOrMobile
                self.accountTextField.text = self.model?.contractNumber
                self.summaTextField.text = self.model?.summa
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = NSLocalizedString("title.paymentByCard", comment: "Оплата картой")
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    private func configuration() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(ButtonPayTableViewCell.self, forCellReuseIdentifier: ButtonPayTableViewCell.identifier)
        // close button
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        // card button
        let cardBtn = getCustomUIBarButtonItem(image: "creditcard.fill", target: self, action: #selector(showCards))
        self.navigationItem.leftBarButtonItems = [cardBtn]
        
        self.summaTextField.addTarget(self, action: #selector(inputSummaTFAction), for: .editingDidEnd)
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func showCards() {
        let credentional = AcquiringSdkCredential(terminalKey: AppConfig.shared.paymentTerminalKey,
                                                  publicKey: AppConfig.shared.paymentPublicKey)
        
        let acquiringSDKConfiguration = AcquiringSdkConfiguration(credential: credentional, server: .prod)
        acquiringSDKConfiguration.logger = AcquiringLoggerDefault()
        
        guard let customerKey = UserDataService.shared.getEmail() else { return }
        let cardListViewConfigration = AcquiringViewConfiguration()
        cardListViewConfigration.viewTitle = NSLocalizedString("title.paymentCardList", comment: "Список карт")
        
        if AppConfig.shared.acquiringSDK {
            cardListViewConfigration.alertViewHelper = self
        }
        
        if let sdk = try? AcquiringUISDK(configuration: acquiringSDKConfiguration) {
            
            sdk.setupCardListDataProvider(for: customerKey)
            
            // открыть экран сиска карт
            sdk.presentCardList(on: self, customerKey: customerKey, configuration: cardListViewConfigration)
            // или открыть экран добавлени карты
            // addCardView(sdk, customerKey, cardListViewConfigration)
            
            sdk.addCardNeedSetCheckTypeHandler = {
                AppConfig.shared.addCardChekType
            }
        }
        
    }
    
    func setUpLayout(){
        accountCell.addSubview(accountTextField)
        accountTextField.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor, constant: 50).isActive = true
        accountTextField.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        
        summaCell.addSubview(summaTextField)
        summaTextField.leadingAnchor.constraint(equalTo: summaCell.leadingAnchor, constant: 50).isActive = true
        summaTextField.centerYAnchor.constraint(equalTo: summaCell.centerYAnchor).isActive = true
        summaTextField.trailingAnchor.constraint(equalTo: summaCell.trailingAnchor, constant: -1).isActive = true
        contactCell.addSubview(contactTextField)
        contactTextField.leadingAnchor.constraint(equalTo: contactCell.leadingAnchor, constant: 50).isActive = true
        contactTextField.centerYAnchor.constraint(equalTo: contactCell.centerYAnchor).isActive = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        if (requestModel != nil) {
            self.contractDelegate?.getStatePayment(for: requestModel!)
            print("getState")
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0, 1, 2, 3:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return accountCell
        case 1:
            return summaCell
        case 2:
            return contactCell
        case 3:
            return buttonPayCell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 1 && indexPath.row == 0 {
            summaTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            contactTextField.becomeFirstResponder()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 2 ? 150 : UITableView.automaticDimension
    }
    
    @objc func inputSummaTFAction(){
        let amount = removeFormatAndSpace(for: summaTextField.text!)
        summaTextField.text = formatRusCurrency(amount)
    }
    
    private func payButtonTap() {
        if isValidSumma(tf: summaTextField) {
            self.purchase()
        } else {
            self.showAlert(title: "Ошибка", mesg: "Некорректная сумма")
        }
    }
}

//MARK: - CONFIGURE
extension PayWithTinkoffViewController {
    
    func purchase() {
        let amount = removeFormatAndSpace(for: self.summaTextField.text!)
        if amount > 4.99 {
            paymentOthersBank()
        } else {
            self.showAlert(
                title: "Ошибка",
                mesg: "Минимальная сумма платежа 5.00₽")
        }
    }
    
    func paymentOthersBank(){
        
        let credentional = AcquiringSdkCredential(terminalKey: AppConfig.shared.paymentTerminalKey,
                                                  publicKey: AppConfig.shared.paymentPublicKey)
        
        let acquiringSDKConfiguration = AcquiringSdkConfiguration(credential: credentional)
        acquiringSDKConfiguration.logger = AcquiringLoggerDefault()
        acquiringSDKConfiguration.fpsEnabled = false
        
        guard let paymentData = createPaymentData() else { return }
        if let sdk = try? AcquiringUISDK(configuration: acquiringSDKConfiguration, style: TinkoffASDKUI.DefaultStyle()) {
            /*sdk.presentPaymentView(on: self, acquiringPaymentStageConfiguration: .init(
                paymentStage: .`init`(paymentData: paymentData)
            ),
                                   configuration: acquiringViewConfiguration(),
                                   tinkoffPayDelegate: nil) { [weak self] response in
                
                self?.responseReviewing(response)
            }*/
        }
        
    }
    private func responseReviewing(_ response: Result<PaymentStatusResponse, Error>) {
        switch response {
        case let .success(result):
            var message = NSLocalizedString("text.paymentStatusAmount", comment: "Покупка на сумму")
            message.append(" \(Utils.formatAmount(result.amount)) ")
            
            if result.status == .cancelled {
                message.append(NSLocalizedString("text.paymentStatusCancel", comment: "отменена"))
            } else {
                message.append(" ")
                message.append(NSLocalizedString("text.paymentStatusSuccess", comment: "paymentStatusSuccess"))
                message.append("\npaymentId = \(result.paymentId)")
            }
            
            if AppConfig.shared.acquiringSDK {
                sdk.presentAlertView(on: self, title: message, icon: result.status == .cancelled ? .error : .success)
            } else {
                let alertView = UIAlertController(title: "Tinkoff Acquaring", message: message, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                present(alertView, animated: true, completion: nil)
            }
            
        case let .failure(error):
            if AppConfig.shared.acquiringSDK {
                sdk.presentAlertView(on: self, title: error.localizedDescription, icon: .error)
            } else {
                let alertView = UIAlertController(title: "Tinkoff Acquaring", message: error.localizedDescription, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    private func createPaymentData() -> PaymentInitData? {
        guard model != nil else { return nil }
        let customerEmail = UserDataService.shared.getEmail()
        let summaPay: NSDecimalNumber = NSDecimalNumber(value: removeFormatAndSpace(for: summaTextField.text ?? "500,00 ₽"))
        let randomOrderId = String(Int64(arc4random()))
        var paymentData = PaymentInitData(amount: summaPay, orderId: randomOrderId, customerKey: customerEmail)
        paymentData.description = "Краткое описние товара"
        
        var receiptItems: [Item] = []
        let item = Item(amount: summaPay.int64Value * 100,
                        price: summaPay.int64Value * 100,
                        name: "Потребленная электроэнергия",
                        tax: .vat20)
        receiptItems.append(item)
        
        paymentData.receipt = Receipt(shopCode: nil,
                                      email: customerEmail,
                                      taxation: .osn,
                                      phone: "",
                                      items: receiptItems,
                                      agentData: nil,
                                      supplierInfo: nil,
                                      customer: nil,
                                      customerInn: nil)
        
        return paymentData
    }
    
    private func acquiringViewConfiguration() -> AcquiringViewConfiguration {
        
        let title = NSAttributedString(string: "Оплата",
                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 22)])
        let amountTitle = NSAttributedString(string: "на сумму " + (summaTextField.text ?? "500,00 ₽"),
                                             attributes: [.font: UIFont.systemFont(ofSize: 17)])
        let detailsFieldTitle = NSAttributedString(string: "Потребленная электроэнергия",
                                                   attributes: [
                                                    .font: UIFont.systemFont(ofSize: 14),
                                                    .foregroundColor: UIColor(red: 0.573, green: 0.6, blue: 0.635, alpha: 1)
                                                   ])
        let config = PaymentConfigurationFactory.makeViewConfiguration(viewTitle: "Оплата", infoFieldTitle: title, infoFieldAmount: amountTitle, detailsFieldTitle: detailsFieldTitle, localizableInfo: "RU")
        return config
    }
    
    private func presentPaymentView(paymentData: PaymentInitData, viewConfigration: AcquiringViewConfiguration) {
        /*sdk.presentPaymentView(on: self,
                               acquiringPaymentStageConfiguration: .init(
                                from: .`init`(paymentData: paymentData)
                               ),
                               configuration: viewConfigration,
                               tinkoffPayDelegate: nil) { [weak self] response in
            self?.responseReviewing(response)
        }*/
    }
}

//MARK: - AcquiringAlertViewProtocol
extension PayWithTinkoffViewController: AcquiringAlertViewProtocol {
    func presentAlertView(_ title: String?, message: String?, dismissCompletion: (() -> Void)?) -> UIViewController? {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "ок", style: .default, handler: { _ in
            dismissCompletion?()
        }))
        
        return alertView
    }
}
