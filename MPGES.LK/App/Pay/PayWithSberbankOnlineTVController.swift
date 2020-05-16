//
//  PayWithSberbankOnlineTVController.swift
//  mpges.lk
//
//  Created by Timur on 08.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PayWithSberbankOnlineTVController: UITableViewController {
    public weak var delegate: ContractDetailsInfoCoordinator?
    
    var sections: [String] {["Лицевой счет", "Доставка электронного чека", ""]}
    var indexPath: IndexPath?
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Подтвердить платеж", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
  
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.contactTextField.text = self.user?.email
                self.accountTextField.text = self.user?.name
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Оплата Сбербанк онлайн"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    override func viewWillLayoutSubviews() {
        self.updateTableViewContentInset()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        //delegate?.getContracts()
    }
    
    @objc func submitAction() {
        //let model = ContractBindingModel(number: accountTextField.text!, code: codeTextField.text!)
        //self.goToBinding(model: model)
        let url = URL(string: "sberbankonline://payments/services/init/?ids=eyJjbiI6eyJiIjoiMjg0IiwibiI6ItCt0LvQtdC60YLRgNC-0Y3QvdC10YDQs9C40Y8iLCJwcyI6IjU1MDY5Njc5NSJ9LCJucyI6eyJub2RlMC5vbmxpbmUuc2JlcmJhbmsucnUiOnsicHMiOiI1MDA2NjQyMDcifSwibm9kZTEub25saW5lLnNiZXJiYW5rLnJ1Ijp7InBzIjoiODQ3NTI1In0sIm5vZGUyLm9ubGluZS5zYmVyYmFuay5ydSI6eyJwcyI6IjUwMDY2NDY5MSJ9LCJub2RlMy5vbmxpbmUuc2JlcmJhbmsucnUiOnsicHMiOiI1MDA2NjQxMDgifSwibm9kZTQub25saW5lLnNiZXJiYW5rLnJ1Ijp7InBzIjoiNTAwNjU4MzkzIn0sIm5vZGU1Lm9ubGluZS5zYmVyYmFuay5ydSI6eyJwcyI6IjUwMDY1ODQ2MyJ9fSwiYXQiOmZhbHNlfQ==&vls=eyJ2cyI6W3sibiI6ItCb0JjQptCV0JLQntCZINCh0KfQldCiIiwidiI6Ijg2MDAwMzAwMDAzIn1dfQ==")
               
        UIApplication.shared.open(url!) { (result) in
            if result {
               // The URL was delivered successfully!
                self.cancelButton()
            }
        }
        //let strURL = "sberbankonline://payments/"
        //let url = URL.init(string: strURL)
        //if (UIApplication.shared.canOpenURL(url!)){
        //    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        //}
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
        if indexPath.section == 2 && indexPath.row == 0 {
            contactTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            submitAction()
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PayWithSberbankOnlineTVController: ContractAddTVControllerUserDelegate {
    
    func resultCheckContract(result: ServerResponseModel) {
        if (result.isError) {
            //accountTextField.shake(times: 3, delta: 5)
        }
        //errorNumberLabel.text = result.message
    }
    
    func checkContractByNumber(model: ContractNumberModel) {
        ApiServiceAdapter.shared.checkByNumberContract(model: model, delegate: self)
    }
    
    func goToBinding(model: ContractBindingModel) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceAdapter.shared.contractBinding(model: model, delegate: self)
    }
    
    func resultToBinding(result: ServerResponseModel) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        AlertControllerAdapter.shared.show(
            title: isError ? "Ошибка" : "Успешно",
            mesg: result.message,
            form: self) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
            }
        }
    }
}

extension PayWithSberbankOnlineTVController {
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
extension PayWithSberbankOnlineTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
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
        
        contactCell.addSubview(contactTextField)
        contactTextField.leadingAnchor.constraint(equalTo: contactCell.leadingAnchor, constant: 50).isActive = true
        contactTextField.centerYAnchor.constraint(equalTo: contactCell.centerYAnchor).isActive = true
    }
}
