//
//  ChangePasswordTVController.swift
//  mpges.lk
//
//  Created by Timur on 20.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ChangePasswordTVController: UITableViewController {
    var sections: [String] {["Текущий пароль", "Новый пароль", ""]}
    
    public weak var delegate: ProfileCoordinator?
    // ФИО
    let currentPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lockOpen, textAlign: .left, accessoryType: .none) }()
    // Пароль
    var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    var confirmPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    // Кнопка
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var currentPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Придумайте пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Повторите пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override func viewDidLoad() {
        self.navigationItem.title = "Новый пароль"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    @objc func refreshData()
    {
        //self.getProfile()
    }
    
    func setUpLayout(){
        currentPasswordCell.addSubview(currentPasswordTextField)
        currentPasswordTextField.leadingAnchor.constraint(equalTo: currentPasswordCell.leadingAnchor, constant: 50).isActive = true
        currentPasswordTextField.centerYAnchor.constraint(equalTo: currentPasswordCell.centerYAnchor).isActive = true
        // Пароль
        passwordCell.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: passwordCell.leadingAnchor, constant: 50).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordCell.centerYAnchor).isActive = true
        confirmPasswordCell.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordCell.leadingAnchor, constant: 50).isActive = true
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
        if indexPath.section == 0 && indexPath.row == 3 {
            saveAlertSheetShow()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            //self.delegate?.navigationEmailToDeveloperPage()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            alertSheetChangePasswordShow()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            alertSheetExitShow()
        }
    }
}

extension ChangePasswordTVController {
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
extension ChangePasswordTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
       
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveAlertSheetShow() {
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы подтверждаете операцию?", form: self) { (UIAlertAction) in

        }
    }
    
    func alertSheetChangePasswordShow() {
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы действительно хотите изменить пароль?", form: self) { (UIAlertAction) in
            print("change pass")
            //self.delegate?.navigationChangePasswordPage()
        }
    }
    func alertSheetExitShow(){
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы действительно хотите выйти из программы?", form: self) { (UIAlertAction) in
            self.delegate?.navigateToFirstPage()
        }
    }
}
