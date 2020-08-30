//
//  PayWithApplePayViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PassKit

public protocol PayWithApplePayTVControllerDelegate: class {
    func setPay(for pay: ApplePayModel)
    func resultOfApplePay(for response: ServerResponseModel)
}

class PayWithApplePayTVController: CenterContentAndCommonTableViewController {
    
    public weak var contractDelegate: ContractDetailsInfoCoordinator?
    public weak var delegate: PayWithApplePayTVControllerDelegate?
    
    var sections: [String] {["Лицевой счет", "Сумма к оплате", "Доставка электронного чека"]}
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    //var saveCell: UITableViewCell { getCustomCell(textLabel: "", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var summaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var applePayPaymentButton: PKPaymentButton = {
        let paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        return paymentButton
    }()
    
    @objc private func applePayButtonTapped(sender: UIButton) {
        if isValidSumma(tf: summaTextField) {
            self.purchase()
        } else {
            AlertControllerAdapter.shared.show(
                title: "Ошибка",
                mesg: "Некорректная сумма",
                form: self)
        }
    }
    
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
        //delegate?.getContracts()
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
        //case 3:
          //  return 1
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
       /* case 3:
            switch indexPath.row {
            case 0:
                return saveCell
            default:
                fatalError()
            }*/
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 0 {
            //cell.isUserInteractionEnabled = false
            
            //cell.addSubview(applePayPaymentButton)
            //applePayPaymentButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            //applePayPaymentButton.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        }
    }
    
    func isValidSumma(tf: UITextField) -> Bool {
        let isValid = true
        if tf.text!.isEmpty { return false }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        
        guard let number = formatter.number(from: tf.text!) else { return false }
        let amount = number.decimalValue
        if amount < 0.00 { return false }
        
        return isValid
    }
    
    @objc func inputSummaTFAction(){
        let formatter = NumberFormatter()
        let sumStr = self.summaTextField.text!
        if let number = formatter.number(from: sumStr) {
            let amount = number.decimalValue
            if amount > 0 {
                summaTextField.text = formatRusCurrency(for: sumStr)
            }
        }
    }
}

//MARK: - CONFIGURE
extension PayWithApplePayTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
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
        
        //saveCell.addSubview(applePayPaymentButton)
        //applePayPaymentButton.centerYAnchor.constraint(equalTo: saveCell.centerYAnchor).isActive = true
        //applePayPaymentButton.leadingAnchor.constraint(equalTo: saveCell.leadingAnchor, constant: 50).isActive = true
        //applePayPaymentButton.trailingAnchor.constraint(equalTo: saveCell.trailingAnchor, constant: -50).isActive = true
        //applePayPaymentButton.topAnchor.constraint(equalTo: saveCell.topAnchor, constant: 2).isActive = true
        //applePayPaymentButton.bottomAnchor.constraint(equalTo: saveCell.bottomAnchor, constant: 2).isActive = true
        //saveCell.addConstraint(NSLayoutConstraint(item: applePayPaymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        //saveCell.addConstraint(NSLayoutConstraint(item: applePayPaymentButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
           
    }
    
    func purchase() {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        
        let sumStr = self.summaTextField.text!
        if let number = formatter.number(from: sumStr) {
            let amount = number.decimalValue
            let paymentRequest = createPaymentRequestForApplePay(sum: NSDecimalNumber(decimal: amount))
            if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                
                controller.delegate = self
                present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func createPaymentRequestForApplePay(sum: NSDecimalNumber) -> PKPaymentRequest {
        let label = "Потребленная электроэнергия"
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.mpges.lk"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["RU"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: label, amount: sum)]
        return request
    }
}
extension PayWithApplePayTVController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        let pd = String(data: payment.token.paymentData.base64EncodedData(), encoding: .utf8)!
        print("pd:" + pd)
        let model = ApplePayModel(EncryptedPaymentData: pd, Amount: Int(5.00), ContractId: self.model!.contractId)
        //setPay(for: model)
        //completion(PKPaymentAuthorizationResult(status:.success, errors: nil))
        
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

extension PayWithApplePayTVController: PayWithApplePayTVControllerDelegate {
   
    func setPay(for pay: ApplePayModel) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceWrapper.shared.initApplePay(model: pay, delegate: self)
    }
    
    func resultOfApplePay(for response: ServerResponseModel) {
        
        let isError = response.isError
            if isError {
                AlertControllerAdapter.shared.show(
                    title: isError ? "Ошибка!" : "Успешно!",
                    mesg: response.message,
                    form: self) { (UIAlertAction) in
                        if isError {
                            self.cancelButton()
                        }
                }
            } else {
//                let url = URL(string: response.data!)
//                UIApplication.shared.open(url!) { (result) in
//                    if result {
//                        self.cancelButton()
//                    }
//                }
            }
            
            self.hiddenAI()
    }
}
