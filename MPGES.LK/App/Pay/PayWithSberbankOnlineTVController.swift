//
//  PayWithSberbankOnlineTVController.swift
//  mpges.lk
//
//  Created by Timur on 08.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol PayWithSberbankOnlineTVControllerDelegate: class {
    func getDeepLink()
    func navigationToSberApp(response: ResponseModel)
}

class PayWithSberbankOnlineTVController: CenterContentAndCommonTableViewController {
    public weak var delegate: ContractDetailsInfoCoordinator?
    
    var sections: [String] {["Лицевой счет", "Доставка электронного чека", ""]}
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Подтвердить платеж", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    
    var model: BankPayModel? {
        didSet {
            DispatchQueue.main.async {
                self.contactTextField.text = self.model?.emailOrMobile
                self.accountTextField.text = self.model?.contractNumber
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Оплата Сбербанк онлайн"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                return contactCell
            default:
                fatalError()
            }
        case 2:
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
            contactTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.getDeepLink()
        }
    }
}

extension PayWithSberbankOnlineTVController: PayWithSberbankOnlineTVControllerDelegate {
    func getDeepLink() {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceWrapper.shared.getDeepLinkForIos(number: Int(model!.contractNumber)!, delegate: self)
    }
    
    func navigationToSberApp(response: ResponseModel) {
        let isError = response.isError
        if isError {
            AlertControllerAdapter.shared.show(
                title: isError ? "Ошибка!" : "Успешно!",
                mesg: response.message!,
                form: self) { (UIAlertAction) in
                    if isError {
                        self.cancelButton()
                    }
            }
        } else {
            let url = URL(string: response.data!)
            UIApplication.shared.open(url!) { (result) in
                if result {
                    self.cancelButton()
                }
            }
        }
        
        self.hiddenAI()
    }
}

//MARK: - CONFIGURE
extension PayWithSberbankOnlineTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.hideKeyboardWhenTappedAround()
    }
    
    func setUpLayout(){
        
        accountCell.addSubview(accountTextField)
        accountTextField.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor, constant: 50).isActive = true
        accountTextField.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        
        contactCell.addSubview(contactTextField)
        contactTextField.leadingAnchor.constraint(equalTo: contactCell.leadingAnchor, constant: 50).isActive = true
        contactTextField.centerYAnchor.constraint(equalTo: contactCell.centerYAnchor).isActive = true
    }
}
