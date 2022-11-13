//
//  SignUpTVController.swift
//  mpges.lk
//
//  Created by Timur on 19.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol SignUpTVControllerUserDelegate: AnyObject {
    func signUp(user: SingUpModel)
    func resultOfCreateUser(result: ResultModel<String>)
}

class SignUpTVController: CommonTableViewController {
    var sections: [String] {["", "ФИО", "Контакты", "Пароль", ""]}

    public weak var delegateUser: SignUpTVControllerUserDelegate?
    public weak var delegate: MainCoordinatorDelegate?
    
    let infoCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: .none, textAlign: .left, accessoryType: .none) }()
    // ФИО
    let nameCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.person, textAlign: .left, accessoryType: .none) }()
    // Контакты
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.mail, textAlign: .left, accessoryType: .none) }()
    var mobileCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.phone, textAlign: .left, accessoryType: .none) }()
    // Пароль
    var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    //var confirmPasswordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    // Кнопка
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Зарегистрировать", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var nameTextField: UITextField = { getCustomTextField(placeholder: "Введите ваше имя") }()
    var emailTextField: UITextField = { getCustomTextField(placeholder: "example@email.com") }()
    var mobileTextField: UITextField = { getCustomTextField(placeholder: "+7(909)-012-34-56") }()
    var passwordTextField: UITextField = { getCustomTextField(placeholder: "Придумайте пароль") }()
    //var confirmPasswordTextField: UITextField = { getCustomTextField(placeholder: "Повторите пароль") }()
    
    var user: UserModel?
    
    override func viewDidLoad() {
        self.navigationItem.title = NSLocalizedString("title.signUp", comment: "Новый пользователь")
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    func setUpLayout(){
        nameCell.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameCell.leadingAnchor, constant: 50).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor).isActive = true
        // контакты
        emailCell.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
        mobileCell.addSubview(mobileTextField)
        mobileTextField.leadingAnchor.constraint(equalTo: mobileCell.leadingAnchor, constant: 50).isActive = true
        mobileTextField.centerYAnchor.constraint(equalTo: mobileCell.centerYAnchor).isActive = true
        // Пароль
        passwordCell.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: passwordCell.leadingAnchor, constant: 50).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordCell.centerYAnchor).isActive = true
        //confirmPasswordCell.addSubview(confirmPasswordTextField)
        //confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordCell.leadingAnchor, constant: 50).isActive = true
        //confirmPasswordTextField.centerYAnchor.constraint(equalTo: confirmPasswordCell.centerYAnchor).isActive = true
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
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 1
        case 4:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                return nameCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return emailCell
            case 1:
                return mobileCell
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return passwordCell
            //case 1:
                //return confirmPasswordCell
            default:
                fatalError()
            }
        case 4:
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
        if section == 0 { return
            """
            Если Вы ранее пользовались веб-версией личного кабинета, то нет необходимости повторно регистрироваться, используйте для входа Ваши логин и пароль
            """ }
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 1 && indexPath.row == 0 {
            nameTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            emailTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            mobileTextField.becomeFirstResponder()
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            passwordTextField.becomeFirstResponder()
        }
        /*if indexPath.section == 2 && indexPath.row == 1 {
            confirmPasswordTextField.becomeFirstResponder()
        }*/
        if indexPath.section == 4 && indexPath.row == 0 {
            createUserAction()
        }
    }
    func createUserAction() {
        if (nameTextField.text!.isEmpty){
            nameTextField.shake(times: 3, delta: 5)
        } else
            if (!isValidEmail(emailTextField.text!) || emailTextField.text!.isEmpty) {
                emailTextField.shake(times: 3, delta: 5)
            } else {
                let user = SingUpModel(name: nameTextField.text!, password: passwordTextField.text!, email: emailTextField.text!, mobile: mobileTextField.text!)
                self.delegateUser?.signUp(user: user)
        }
    }
}

extension SignUpTVController: SignUpTVControllerUserDelegate {
    
    func signUp(user: SingUpModel) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceWrapper.shared.signUp(model: user, delegate: self)
    }
    
    func resultOfCreateUser(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        self.showAlert(
            title: isError ? "Ошибка" : "Успешно",
            mesg: result.message!) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
                }
        }
    }
    
}

//MARK: - CONFIGURE
extension SignUpTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        self.delegateUser = self
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}
