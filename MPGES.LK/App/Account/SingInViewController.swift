//
//  ViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingInViewControllerUserDelegate: class {
    func authApi(model: AuthModel)
    func resultAuthApi(modelResult: ResultModel)
}

class SingInViewController: UIViewController {

    public weak var delegate: MainCoordinatorDelegate?
    public weak var delegateUser: SingInViewControllerUserDelegate?
    
    let userDataService = UserDataService()
    let apiService = ApiService()
    
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    @IBAction func recoveryPassBtn(_ sender: Any) {
        self.delegate?.navigateToRecoveryPasswordPage()
    }
    @objc func demoButton() {
        let model = AuthModel(email: "demo@mp-ges.ru", password: "Qwerty123!")
        self.delegateUser?.authApi(model: model)
    }
    
    @IBAction func authButton(_ sender: Any) {
        debugPrint("authButton press")
        if isValidEmail(emailTF.text!) {
            let model = AuthModel(email: emailTF.text!, password: passwordTF.text!)
            self.delegateUser?.authApi(model: model)
        } else
        {
            //emailTF.layer.borderColor = UIColor.red.cgColor
            //emailTF.layer.borderWidth = 1.0
            errorEmailLabel.text = "Не верный email"
            emailTF.shake(times: 3, delta: 5)
        }
    }
    
    override func viewDidLoad() {
        self.title = "Войти"
        super.viewDidLoad()
        configuration()
    }
}

extension SingInViewController: SingInViewControllerUserDelegate {
    func authApi(model: AuthModel) {
        errorEmailLabel.text = ""
        errorPasswordLabel.text = ""
        ActivityIndicatorViewService.shared.showView(form: self.view)
        ApiServiceAdapter.shared.authApi(model: model, delegate: self)
    }
    
func resultAuthApi(modelResult: ResultModel) {
    ActivityIndicatorViewService.shared.hideView()
    if !modelResult.isError {
        userDataService.setToken(token: modelResult.data!)
        self.delegate?.goToNextSceneApp()
        navigationController?.isNavigationBarHidden = true
    } else {
        switch modelResult.errorCode {
        case 0:
            emailTF.shake(times: 3, delta: 5)
            errorEmailLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
        case 1:
            passwordTF.shake(times: 3, delta: 5)
            errorPasswordLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
        default:
            emailTF.shake(times: 3, delta: 5)
            passwordTF.shake(times: 3, delta: 5)
            errorEmailLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
        }
    }
}

}
extension SingInViewController {
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
extension SingInViewController {
    private func configuration() {
        let demoBtn = UIBarButtonItem(title: "Demo", style: .plain, target: self, action: #selector(demoButton))
        self.navigationItem.rightBarButtonItems = [demoBtn]
        passwordTF.isSecureTextEntry = true
        errorEmailLabel.text = ""
        submitBtn.Circle()
        delegateUser = self
        self.hideKeyboardWhenTappedAround()
    }
}
