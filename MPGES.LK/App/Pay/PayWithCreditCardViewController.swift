//
//  PayWithCreditCardViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PayWithCreditCardViewController: UITableViewController {
    
    public weak var delegate: ContractDetailsInfoCoordinator?
    
    var sections: [String] {["Лицевой счет", "Реквизиты банковской карты", "Доставка электронного чека",""]}
    var indexPath: IndexPath?
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var cardNumberCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.edit, textAlign: .left, accessoryType: .none) }()
    var cardNameCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var cardDateCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var cardCodeCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Подтвердить платеж", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "Например: 860001000001") }()
    var cardNumberTextField: UITextField = { getCustomTextField(placeholder: "0000 0000 0000 0000") }()
    var cardNameTextField: UITextField = { getCustomTextField(placeholder: "NAME SURNAME") }()
    var cardDateTextField: UITextField = { getCustomTextField(placeholder: "MM/YY") }()
    var codeTextField: UITextField = { getCustomTextField(placeholder: "XXX") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    
    var cardNumberLabel: UILabel = { getCustomForCardLabel(text: "Номер") }()
    var cardNameLabel: UILabel = { getCustomForCardLabel(text: "Владелец") }()
    var cardDateLabel: UILabel = { getCustomForCardLabel(text: "Действительна до") }()
    var cardCodeLabel: UILabel = { getCustomForCardLabel(text: "CVC/CVV code") }()

    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.codeTextField.text = self.user?.email
                self.accountTextField.text = self.user?.name
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Оплата банк. картой"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    override func viewWillLayoutSubviews() {
        //self.updateTableViewContentInset()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        //delegate?.getContracts()
    }
    
    @objc func submitAction() {
        let model = ContractBindingModel(number: accountTextField.text!, code: codeTextField.text!)
        self.goToBinding(model: model)
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
            return 4
        case 2:
            return 1
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
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return cardNumberCell
            case 1:
                return cardDateCell
            case 2:
                return cardNameCell
            case 3:
                return cardCodeCell
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
        case 3:
        switch indexPath.row {
        case 0:
            return saveCell
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
            cardNumberTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            cardDateTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            cardNameTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 3 {
            codeTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            contactTextField.becomeFirstResponder()
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            submitAction()
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PayWithCreditCardViewController: ContractAddTVControllerUserDelegate {
    
    func resultCheckContract(result: ServerResponseModel) {
        if (result.isError) {
            accountTextField.shake(times: 3, delta: 5)
        }
        //errorNumberLabel.text = result.message
    }
    
    func checkContractByNumber(model: ContractNumberModel) {
        ApiServiceWrapper.shared.checkByNumberContract(model: model, delegate: self)
    }
    
    func goToBinding(model: ContractBindingModel) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceWrapper.shared.contractBinding(model: model, delegate: self)
    }
    
    func resultToBinding(result: ServerResponseModel) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        AlertControllerAdapter.shared.show(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message,
            form: self) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
            }
        }
    }
}

extension PayWithCreditCardViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - CONFIGURE
extension PayWithCreditCardViewController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0)
    }
    
    func setUpLayout(){
        
        accountCell.addSubview(accountTextField)
        accountTextField.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor, constant: 50).isActive = true
        accountTextField.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        
        cardNumberCell.addSubview(cardNumberLabel)
        cardNumberCell.addSubview(cardNumberTextField)
        cardNumberLabel.leadingAnchor.constraint(equalTo: cardNumberCell.leadingAnchor, constant: 50).isActive = true
        cardNumberLabel.centerYAnchor.constraint(equalTo: cardNumberCell.centerYAnchor).isActive = true
        cardNumberTextField.rightAnchor.constraint(equalTo: cardNumberCell.rightAnchor, constant: -20).isActive = true
        cardNumberTextField.centerYAnchor.constraint(equalTo: cardNumberCell.centerYAnchor).isActive = true
        
        cardDateCell.addSubview(cardDateLabel)
        cardDateCell.addSubview(cardDateTextField)
        cardDateLabel.leadingAnchor.constraint(equalTo: cardDateCell.leadingAnchor, constant: 50).isActive = true
        cardDateLabel.centerYAnchor.constraint(equalTo: cardDateCell.centerYAnchor).isActive = true
        cardDateTextField.rightAnchor.constraint(equalTo: cardDateCell.rightAnchor, constant: -20).isActive = true
        cardDateTextField.centerYAnchor.constraint(equalTo: cardDateCell.centerYAnchor).isActive = true
        
        cardNameCell.addSubview(cardNameLabel)
        cardNameCell.addSubview(cardNameTextField)
        cardNameLabel.leadingAnchor.constraint(equalTo: cardNameCell.leadingAnchor, constant: 50).isActive = true
        cardNameLabel.centerYAnchor.constraint(equalTo: cardNameCell.centerYAnchor).isActive = true
        cardNameTextField.rightAnchor.constraint(equalTo: cardNameCell.rightAnchor, constant: -20).isActive = true
        cardNameTextField.centerYAnchor.constraint(equalTo: cardNameCell.centerYAnchor).isActive = true
        
        cardCodeCell.addSubview(cardCodeLabel)
        cardCodeCell.addSubview(codeTextField)
        cardCodeLabel.leadingAnchor.constraint(equalTo: cardCodeCell.leadingAnchor, constant: 50).isActive = true
        cardCodeLabel.centerYAnchor.constraint(equalTo: cardCodeCell.centerYAnchor).isActive = true
        codeTextField.rightAnchor.constraint(equalTo: cardCodeCell.rightAnchor, constant: -20).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: cardCodeCell.centerYAnchor).isActive = true
    }
}
