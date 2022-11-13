//
//  ChangePasswordTVController.swift
//  mpges.lk
//
//  Created by Timur on 20.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol PageEnterCodeTVControllerDelegate: AnyObject {
    func requestForChange(model: PasswordChangeModel)
    func responseOfChange(result: ResultModel<String>)
}

class PageEnterCodeTVController: CommonTableViewController {
    
    var sections: [String] {["Email", "Код подтверждения", ""]}
    
    public weak var delegateProfile: ProfileCoordinator?
    
    // ФИО
    let currentEmailCell: UITableViewCell = { getCustomCell(textLabel: "",
                                                            imageCell: AppImage.at,
                                                               textAlign: .left, accessoryType: .none) }()
    var emailLabel: UILabel = { getCustomLabel(
                                    text: UserDataService.shared.getKey(keyName: "email") ?? "") }()
    // Код
    var codeCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    var getCodeCell: UITableViewCell = { getCustomCell(textLabel: "Запросить код", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }()
    var codeTextField: UITextField = { getCustomTextField(placeholder: "XXXXXX", isPassword: true) }()
    
    // Кнопка
    var saveCell: UITableViewCell = { getCustomCell(textLabel: "Удалить", imageCell: .none, textAlign: .center, textColor: .systemRed, accessoryType: .none, isUserInteractionEnabled: true, selectionStyle: .blue) }()
    
    private lazy var getCodeButton: UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("   Запросить   ", for: .normal)
        b.titleLabel?.textColor = .black
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        b.backgroundColor = .systemBlue
        b.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        b.layer.cornerRadius = 8.0
        b.layer.borderWidth = 1.0
        b.layer.borderColor = UIColor.systemBlue.cgColor
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    @objc func tapButton() {
        self.showAlert(title: "Информация", mesg: "На указанный Вами email адрес направили письмо с КОДОМ ПОДТВЕРЖДЕНИЯ. Код действителен в течение 3-х МИНУТ")
        print(#function)
    }
    
    func setUpLayout(){
        let inset: CGFloat = 50
        currentEmailCell.contentView.addSubview(emailLabel)
        emailLabel.leftAnchor.constraint(equalTo: currentEmailCell.leftAnchor, constant: inset).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: currentEmailCell.centerYAnchor).isActive = true
        // Пароль
        codeCell.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: codeCell.leadingAnchor, constant: inset).isActive = true
        //codeTextField.trailingAnchor.constraint(equalTo: codeCell.trailingAnchor, constant: -100).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
        codeCell.addSubview(getCodeButton)
        getCodeButton.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
        //getCodeButton.leadingAnchor.constraint(equalTo: codeCell.leadingAnchor, constant: 100).isActive = true
        getCodeButton.trailingAnchor.constraint(equalTo: codeCell.trailingAnchor, constant: -25).isActive = true
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0, 1, 2:
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
                return currentEmailCell
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
        if indexPath.section == 1 && indexPath.row == 0 {
            codeTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            //confirmPasswordTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            changePassword()
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 2 && indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    func changePassword() {
       // if (self.isValidData())
       // {
            //let model = PasswordChangeModel( currentPassword: self.currentPasswordTextField.text!, newPassword: self.passwordTextField.text!)
            //self.requestForChange(model: model)
       // } else
      //  {
            self.hiddenAI()
      //  }
    }
    
    func isValidData()->Bool {
        let result: Bool = true
        if !((self.codeTextField.text) != nil)
        {
            self.showAlert(title: "Ошибка", mesg: "Новый пароль и пароль подтверждения не совпадают")
            return false
        }
        return result
    }
}


//MARK: - CONFIGURE
extension PageEnterCodeTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}

extension PageEnterCodeTVController: PageEnterCodeTVControllerDelegate {
    func requestForChange(model: PasswordChangeModel) {
        //ApiServiceWrapper.shared.passwordChange(model: model, delegate: self)
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
