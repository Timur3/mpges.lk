//
//  PasswordResetTVController.swift
//  mpges.lk
//
//  Created by Timur on 20.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol PasswordResetTVControllerDelegate: AnyObject {
    func requestForReset(model: PasswordResetModel)
    func responseOfReset(result: ResultModel<String>)
}

class PasswordResetTVController: CommonTableViewController {
    
    var sections: [String] {["Новый пароль", "Код подтверждения", ""]}
    
    public weak var delegateProfile: ProfileCoordinator?
    public var email: String?
    
    let codeCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lockOpen, textAlign: .left, accessoryType: .none) }()
    // Пароль
    var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    var confirmPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    // Кнопка
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var codeTextField: UITextField = { getCustomTextField(placeholder: "Код") }()
    var passwordTextField: UITextField = { getCustomTextField(placeholder: "Придумайте пароль", isPassword: true) }()
    var confirmPasswordTextField: UITextField = { getCustomTextField(placeholder: "Повторите пароль", isPassword: true) }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новый пароль"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    func setUpLayout(){
        codeCell.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: codeCell.leadingAnchor, constant: 50).isActive = true
        codeTextField.trailingAnchor.constraint(equalTo: codeCell.trailingAnchor, constant: -1).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
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
            return 2
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
                return passwordCell
            case 1:
                return confirmPasswordCell
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
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 1 ? "На указанный Вами email адрес направили письмо с КОДОМ ПОДТВЕРЖДЕНИЯ. Код действителен в течение 3-х МИНУТ" : ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        if indexPath.section == 0 && indexPath.row == 0 {
            passwordTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            confirmPasswordTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            codeTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            alertSheetChangePasswordShow()
        }
    }
    func alertSheetChangePasswordShow() {
        if (self.isValidData())
        {
            let model = PasswordResetModel(newPassword: self.passwordTextField.text!, login: self.email!, code: self.codeTextField.text!)
            self.requestForReset(model: model)
        } else {
            self.hiddenAI()
        }
    }
    
    func isValidData()->Bool {
        let result: Bool = true
        if (self.passwordTextField.text!.isEmpty) {
            self.showAlert(title: "Ошибка", mesg: "Пустой пароль")
            return false
        }
        else
        if (self.passwordTextField.text != self.confirmPasswordTextField.text)
        {
            self.showAlert(title: "Ошибка", mesg: "Новый пароль и пароль подтверждения не совпадают")
            return false
        } else
        if (self.codeTextField.text!.isEmpty) {
            self.showAlert(title: "Ошибка", mesg: "Пустой КОД")
            return false
        }
        return result
    }
}


//MARK: - CONFIGURE
extension PasswordResetTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}

extension PasswordResetTVController: PasswordResetTVControllerDelegate {
    func requestForReset(model: PasswordResetModel) {
        ApiServiceWrapper.shared.passwordReset(model: model, delegate: self)
    }
    
    func responseOfReset(result: ResultModel<String>) {
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
