//
//  ContractAddTVController.swift
//  mpges.lk
//
//  Created by Timur on 18.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ContractAddTVControllerUserDelegate: class {
    func checkContractByNumber(model: ContractNumberModel)
    func resultCheckContract(result: ServerResponseModel)
    func goToBinding(model: ContractBindingModel)
    func resultToBinding(result: ServerResponseModel)
}

class ContractAddTVController: CommonTableViewController {
    public weak var delegate: ContractsTVControllerUserDelegate?
    
    var sections: [String] {["Лицевой счет", "Код подтверждения", ""]}
    
    var numberCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var codeCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.edit, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Например: 860001000001"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "XXXXXX"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.codeTextField.text = self.user?.email
                self.numberTextField.text = self.user?.name
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Добавить договор"
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
        self.delegate?.getContracts()
    }
    
    func setUpLayout(){
        numberCell.addSubview(numberTextField)
        numberTextField.leadingAnchor.constraint(equalTo: numberCell.leadingAnchor, constant: 50).isActive = true
        numberTextField.centerYAnchor.constraint(equalTo: numberCell.centerYAnchor).isActive = true
        codeCell.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: codeCell.leadingAnchor, constant: 50).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
    }
    
    @objc func submitAction() {
        let model = ContractBindingModel(number: numberTextField.text!, code: codeTextField.text!)
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
                return numberCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return codeCell
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
        if indexPath.section == 0 && indexPath.row == 0 {
            numberTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            codeTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            submitAction()
        }
    }
}

extension ContractAddTVController: ContractAddTVControllerUserDelegate {
    
    func resultCheckContract(result: ServerResponseModel) {
        if (result.isError) {
            numberTextField.shake(times: 3, delta: 5)
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

//MARK: - CONFIGURE
extension ContractAddTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
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
}
