//
//  PayWithSberPayViewController.swift
//  mpges.lk
//
//  Created by Timur on 06.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit
import SberPaySDK


class PayWithSberPayViewController: CommonTableViewController {
    
    public weak var contractDelegate: ContractDetailsInfoTVControllerUserDelegate?
    
    var sections: [String] {["Лицевой счет", "Сумма к оплате", "Доставка электронного чека"]}
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.rub, textAlign: .left, accessoryType: .none) }()
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.mail, textAlign: .left, accessoryType: .none) }()
    
    
    private var buttonPayCell1: ButtonSberPayTableViewCell = {
        var cell = ButtonSberPayTableViewCell()
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .red
        cell.onButtonTouch = {
            //self.payButtonTap()
            print(#function)
        }
        return cell
    }()
    
    var button: PayButton = {
        let payButton = PayButton()
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.cornerRadius = 8
        return payButton
    }()
    
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
        print(#function)
        let requestModel = PaymentRequest(invoiceId: "235980")
        SberPay.pay(with: requestModel)
    }
    
    
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
        self.navigationItem.title = NSLocalizedString("title.sberPay", comment: "Оплата картой")
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
        return section == 3 ? 150 : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            //footerView.backgroundColor = .black
            footerView.addSubview(button)
            button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
            button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 70).isActive = true
            return footerView
        }
        return UIView()
    }
    
    @objc func inputSummaTFAction(){
        let amount = removeFormatAndSpace(for: summaTextField.text!)
        summaTextField.text = formatRusCurrency(amount)
    }
    
    func payButtonTap() {
        print(#function)
        if isValidSumma(tf: summaTextField) {
            self.purchase()
        } else {
            self.showAlert(title: "Ошибка", mesg: "Некорректная сумма")
        }
    }
}
