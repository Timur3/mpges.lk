//
//  SingInTVController.swift
//  mpges.lk
//
//  Created by Timur on 23.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingInTVControllerUserDelegate: class {
    func authApi(model: AuthModel)
    func resultAuthApi(result: ResultModel)
}

class SingInTVController: UITableViewController {
    var sections: [String] {["Авторизация", "", ""]}
    let userDataService = UserDataService()
    var indexPath: IndexPath?
    public weak var delegate: MainCoordinator?
    public weak var delegateUser: SingInTVControllerUserDelegate?
    
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    var inputCell: UITableViewCell { getCustomCell(textLabel: "Войти", imageCell: myImage.none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var passwordRecoveryCell: UITableViewCell { getCustomCell(textLabel: "Забыли пароль", imageCell: myImage.none, textAlign: .center, textColor: .systemRed, accessoryType: .none) }
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@email.com"
        textField.text = "timon2006tevriz@mail.ru"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.emailTextField.text = self.user?.email
                self.passwordTextField.text = self.user?.name
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Войти"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewWillLayoutSubviews() {
        self.updateTableViewContentInset()
    }
    
    func setUpLayout(){
        emailCell.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
        passwordCell.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: passwordCell.leadingAnchor, constant: 50).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordCell.centerYAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: passwordCell.rightAnchor, constant: 8).isActive = true
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
                return emailCell
            case 1:
                return passwordCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return inputCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return passwordRecoveryCell
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
        return section == 0 ?
            """
            Нажимая  кнопку "Войти", Вы принимаете условия пользовательского соглашения и политики конфиденциальности
            """ : ""
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            emailTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            passwordTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            debugPrint("authButton press")
            let access = ApiService.Connectivity.isConnectedToInternet
            if access {
                if isValidEmail(emailTextField.text!) {
                    let model = AuthModel(email: emailTextField.text!, password: passwordTextField.text!)
                    self.delegateUser?.authApi(model: model)
                } else
                {
                    let msg = "Не корректный email адрес"
                    AlertControllerAdapter.shared.show(
                        title: "Ошибка",
                        mesg: msg,
                        form: self) { (UIAlertAction) in
                            print(msg as Any)
                    }
                    emailTextField.shake(times: 3, delta: 5)
                }
            } else {
                let msg = "Нет соединения с интернетом"
                AlertControllerAdapter.shared.show(
                    title: "Ошибка",
                    mesg: msg,
                    form: self) { (UIAlertAction) in
                        print(msg as Any)
                }
            }
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.delegate?.navigateToRecoveryPasswordPage()
        }
    }
    
    @objc func geToDemo() {
        let model = AuthModel(email: "demo@mp-ges.ru", password: "Qwerty123!")
        self.delegate?.authApi(model: model)
    }
}

//MARK: - CONFIGURE
extension SingInTVController {
    private func configuration() {
        let demoBtn = UIBarButtonItem(title: "Demo", style: .plain, target: self, action: #selector(geToDemo))
        self.navigationItem.rightBarButtonItems = [demoBtn]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        delegateUser = self
    }
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SingInTVController: SingInTVControllerUserDelegate {
    
    func authApi(model: AuthModel) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceAdapter.shared.authApi(model: model, delegate: self)
    }
    
    func resultAuthApi(result: ResultModel) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        if !result.isError {
            userDataService.setToken(token: result.data!)
            self.delegate?.goToNextSceneApp()
            navigationController?.isNavigationBarHidden = true
        } else {
            AlertControllerAdapter.shared.show(
                title: "Ошибка",
                mesg: result.errorMessage!,
                form: self) { (UIAlertAction) in
                    print(result.errorMessage as Any)
            }
        }
    }
}
