//
//  ChangePasswordTVController.swift
//  mpges.lk
//
//  Created by Timur on 20.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol PasswordChangeTVControllerDelegate: class {
    func requestForChange(model: PasswordChangeModel)
    func responseOfChange(result: ResultModel<String>)
}

class PasswordChangeTVController: CommonTableViewController {
    
    var sections: [String] {["Текущий пароль", "Новый пароль", ""]}
    
    public weak var delegateProfile: ProfileCoordinator?
    
    // ФИО
    let currentPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lockOpen, textAlign: .left, accessoryType: .none) }()
    // Пароль
    var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    var confirmPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    // Кнопка
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var currentPasswordTextField: UITextField = { getCustomTextField(placeholder: "Ваш пароль", isPassword: true) }()
    var passwordTextField: UITextField = { getCustomTextField(placeholder: "Придумайте пароль", isPassword: true) }()
    var confirmPasswordTextField: UITextField = { getCustomTextField(placeholder: "Повторите пароль", isPassword: true) }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новый пароль"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    func setUpLayout(){
        currentPasswordCell.addSubview(currentPasswordTextField)
        currentPasswordTextField.leadingAnchor.constraint(equalTo: currentPasswordCell.leadingAnchor, constant: 50).isActive = true
        currentPasswordTextField.trailingAnchor.constraint(equalTo: currentPasswordCell.trailingAnchor, constant: -1).isActive = true
        currentPasswordTextField.centerYAnchor.constraint(equalTo: currentPasswordCell.centerYAnchor).isActive = true
        // Пароль
        passwordCell.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: passwordCell.leadingAnchor, constant: 50).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordCell.trailingAnchor, constant: -1).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordCell.centerYAnchor).isActive = true
        confirmPasswordCell.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordCell.leadingAnchor, constant: 50).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordCell.trailingAnchor, constant: -1).isActive = true
        confirmPasswordTextField.centerYAnchor.constraint(equalTo: confirmPasswordCell.centerYAnchor).isActive = true
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
            return 2
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
                return currentPasswordCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return passwordCell
            case 1:
                return confirmPasswordCell
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
            currentPasswordTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            passwordTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            confirmPasswordTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            changePassword()
        }
    }
    
    func changePassword() {
        if (self.isValidData())
        {
            let model = PasswordChangeModel( currentPassword: self.currentPasswordTextField.text!, newPassword: self.passwordTextField.text!)
            self.requestForChange(model: model)
        } else
        {
            self.hiddenAI()
        }
    }
    
    func isValidData()->Bool {
        let result: Bool = true
        if (self.currentPasswordTextField.text!.isEmpty) {
            self.showAlert(title: "Ошибка", mesg: "Пустой пароль")
            return false
        } else
        if (self.passwordTextField.text != self.confirmPasswordTextField.text)
        {
            self.showAlert(title: "Ошибка", mesg: "Новый пароль и пароль подтверждения не совпадают")
            return false
        }
        return result
    }
}


//MARK: - CONFIGURE
extension PasswordChangeTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}

extension PasswordChangeTVController: PasswordChangeTVControllerDelegate {
    func requestForChange(model: PasswordChangeModel) {
        ApiServiceWrapper.shared.passwordChange(model: model, delegate: self)
    }
    
    func responseOfChange(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        
        self.showAlert(
            title: isError ? "Ошибка" : "Успешно",
            mesg: result.message!) { (UIAlertAction) in
            if !isError {
                self.cancelButton()
                self.delegateProfile?.navigateToFirstPage()
            }
        }
    }
    
    
}
