//
//  PayWithApplePayViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PassKit
import Alamofire

class PayWithApplePayTVController: CommonTableViewController {
    
    public weak var contractDelegate: ContractDetailsInfoTVControllerUserDelegate?
    
    var sections: [String] {["Лицевой счет", "Сумма к оплате", "Доставка электронного чека"]}
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }()
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var summaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        //textField.
        return textField
    }()
    
    var applePayPaymentButton: PKPaymentButton = {
        let paymentButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .whiteOutline)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        return paymentButton
    }()
    
    
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
        self.navigationItem.title = "Оплата Apple Pay"
        super.viewDidLoad()
        configuration()
        setUpLayout()
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
        case 0:
            return 1
        case 1:
            return 1
        case 2:
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
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return summaCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return contactCell
            default:
                fatalError()
            }
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
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            //footerView.backgroundColor = .black
            footerView.addSubview(applePayPaymentButton)
            applePayPaymentButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
            applePayPaymentButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
            return footerView
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 2 ? 150 : UITableView.automaticDimension
    }
    
    @objc func inputSummaTFAction(){
        let amount = removeFormatAndSpace(for: summaTextField.text!)
        summaTextField.text = formatRusCurrency(amount)
    }
    
    @objc private func applePayButtonTapped(sender: UIButton) {
        if isValidSumma(tf: summaTextField) {
            self.purchase()
        } else {
            self.showAlert(title: "Ошибка", mesg: "Некорректная сумма")
        }
    }
}

//MARK: - CONFIGURE
extension PayWithApplePayTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.summaTextField.addTarget(self, action: #selector(inputSummaTFAction), for: .editingDidEnd)
        self.hideKeyboardWhenTappedAround()
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
    
    func purchase() {
        let amount = removeFormatAndSpace(for: self.summaTextField.text!)
        if amount > 4.99 {
        let paymentRequest = createPaymentRequestForApplePay(sum: NSDecimalNumber(decimal: amount))
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                controller.delegate = self
                present(controller, animated: true, completion: nil)
            }
        } else {
            self.showAlert(
                title: "Ошибка",
                mesg: "Минимальная сумма платежа 5.00₽")
        }
    }
    
    func createPaymentRequestForApplePay(sum: NSDecimalNumber) -> PKPaymentRequest {
        let label = "ООО \"ГЭС\""
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.oooges.lk"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["RU"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        //request.billingContact =
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: label, amount: sum)]
        return request
    }
}
extension PayWithApplePayTVController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        var sum: Decimal = 0.00
        let pd = String(data: payment.token.paymentData.base64EncodedData(), encoding: .utf8)!
        print("pd:" + pd)
        
        let sumStr = self.summaTextField.text!
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        if let number = formatter.number(from: sumStr) {
            sum = number.decimalValue
        }
        let model = ApplePayModel(encryptedPaymentData: pd, amount: sum, contractId: self.model!.contractId)
        
        self.requestModel = RequestOfPayModel(id: 0, summa: sum)
        ApiService.shared.requestByModel(model: model, method: "payment/initApplePay") { (response: ResultModel<String>) in
            if (!response.isError) {
                self.requestModel?.id = Int(response.data!)!
                completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
            } else
            {
                completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        //self.getStatePayment(for: self.requestModel!)
    }
}
