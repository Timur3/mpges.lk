//
//  SignInTVController.swift
//  mpges.lk
//
//  Created by Timur on 23.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SignInTVControllerUserDelegate: AnyObject {
    func authApi(model: SignInModel)
    func resultAuthApi(result: ResultModel<TokensModel>)
}

class SignInTVController: CenterContentAndCommonTableViewController {
    private var sections: [String] {["Авторизация", "", ""]}
    private let userDataService = UserDataService.shared
    private let keyChain = KeyChain.shared
    
    public weak var delegate: MainCoordinator?
    public weak var delegateUser: SignInTVControllerUserDelegate?
    
    private var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.mail, textAlign: .left, accessoryType: .none) }()
    private var passwordCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    private var inputCell: UITableViewCell { getCustomCell(textLabel: NSLocalizedString("button.signIn", comment: "Войти"), imageCell: AppImage.none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    private var passwordRecoveryCell: UITableViewCell { getCustomCell(textLabel: "Забыли пароль", imageCell: AppImage.none, textAlign: .center, textColor: .systemRed, accessoryType: .none) }
    
    private var emailTextField: UITextField = { getCustomTextField(placeholder: "example@email.com", keyboardType: .emailAddress) }()
    private var passwordTextField: UITextField = { getCustomTextField(placeholder: "Ваш пароль", isPassword: true) }()
    
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.emailTextField.text = self.user?.email
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        configuration()
    }
    
    private func getPassFromKeyChain() {
        guard let pass = keyChain.read(account: emailTextField.text!) else { return }
        passwordTextField.text = String(decoding: pass, as: UTF8.self)
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
        case 1, 2:
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
                guard let password = passwordTextField.text else { return }
                if password.count == 0 {
                    passwordTextField.shake(times: 3, delta: 5)
                    return
                }
                if isValidEmail(emailTextField.text!) {
                    let deviceId = UIDevice.current.identifierForVendor!.uuidString
                    let model = SignInModel(email: emailTextField.text!, password: passwordTextField.text!, deviceId: deviceId)
                    self.delegateUser?.authApi(model: model)
                } else
                {
                    let msg = "Некорректный email адрес"
                    self.showAlert(
                        title: "Ошибка",
                        mesg: msg) { (UIAlertAction) in
                            print(msg as Any)
                    }
                    emailTextField.shake(times: 3, delta: 5)
                }
            } else {
                let msg = "Нет соединения с интернетом"
                self.showAlert(
                    title: "Ошибка",
                    mesg: msg) { (UIAlertAction) in
                        print(msg as Any)
                }
            }
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.delegate?.navigateToPasswordRecoveryPage()
        }
    }
    
    @objc func geToDemo() {
        let deviceId = String(UIDevice.current.identifierForVendor!.hashValue)
        let model = SignInModel(email: "demo@mp-ges.ru", password: "Qwerty123!", deviceId: deviceId)
        ApiServiceWrapper.shared.authApi(model: model, delegate: self)
    }
}

//MARK: - CONFIGURE
extension SignInTVController {
    private func configuration() {
        self.navigationItem.title = NSLocalizedString("title.signIn", comment: "Войти")
        let demoBtn = UIBarButtonItem(title: "Demo", style: .plain, target: self, action: #selector(geToDemo))
        self.navigationItem.rightBarButtonItems = [demoBtn]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        delegateUser = self
        //-- заполняем email
        self.emailTextField.text = userDataService.getEmail()
        //self.passwordTextField.text = userDataService.getKey(keyName: "dwp")
        getPassFromKeyChain()
        //-- глаз
        passwordCell.accessoryView = getEyeImageView(AppImage.eye.rawValue)
        
        emailTextField.textContentType = .username
        passwordTextField.textContentType = .password
    }
    
    private func getEyeImageView(_ imageName: String) -> UIImageView {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 18))
        imgView.image = UIImage(systemName: imageName)
        imgView.isUserInteractionEnabled = true
        imgView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(showOrHidePassword))]
        return imgView
    }
    
    @objc private func showOrHidePassword() {
        if passwordTextField.isSecureTextEntry {
            passwordCell.accessoryView = getEyeImageView(AppImage.eyeSlash.rawValue)
        } else {
            passwordCell.accessoryView = getEyeImageView(AppImage.eye.rawValue)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
}

extension SignInTVController: SignInTVControllerUserDelegate {
    func authApi(model: SignInModel) {
        let email = model.email.lowercased()
        if (self.indexPath != nil) {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        }
        userDataService.setEmail(email)
        //String(decoding: Data, as: UTF8.self)
        keyChain.save(model.password.data(using: String.Encoding.utf8)!, account: email)
        ApiServiceWrapper.shared.authApi(model: model, delegate: self)
    }
    
    func resultAuthApi(result: ResultModel<TokensModel>) {
        if (self.indexPath != nil) {
            ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        }
        if !result.isError {
            showToast(message: "Успешно")
            userDataService.setToken(result.data!.accessToken)
            userDataService.setRefreshToken(result.data!.refreshToken)
            userDataService.setIsAuth()
            
            self.delegate?.goToNextSceneApp()
            navigationController?.isNavigationBarHidden = true
        } else {
            self.showAlert(title: "Ошибка", mesg: result.message!) { (UIAlertAction) in
                print(result.message as Any)
            }
        }
    }
}
