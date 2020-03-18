//
//  RecoveryPasswordViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol RecoveryPasswordViewControllerDelegate: class {
    func navigateToSingInPage()
}

public protocol RecoveryPasswordViewControllerUserDelegate: class {
    func goToRecoveryPassword()
    func resultOfCheckEmail(result: ServerResponseModel)
    func resultOfPassordRecovery(result: ServerResponseModel)
}

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendPassword: UIButton!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    public weak var delegate: RecoveryPasswordViewControllerDelegate?
    public weak var delegateUser: RecoveryPasswordViewControllerUserDelegate?
    private var model: UserEmailModel?
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.delegate?.navigateToSingInPage()
    }
    @IBAction func emailChange(_ sender: UITextField) {
        if (isValidEmail(emailTF.text!)) {
            ActivityIndicatorViewService.shared.showView(form: self.view)
            model = UserEmailModel(email: emailTF.text!)
            ApiServiceAdapter.shared.checkByEmail(model: model!, delegate: self)
        } else {
            sendPassword.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Восстановление пароля"
        sendPassword.isEnabled = false
        super.viewDidLoad()
        sendPassword.addTarget(self, action: #selector(goToRecoveryPassword), for: .touchUpInside)
        sendPassword.Circle()
        delegateUser = self
        // Do any additional setup after loading the view.
    }
}
extension RecoveryPasswordViewController: RecoveryPasswordViewControllerUserDelegate {
    func resultOfCheckEmail(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        sendPassword.isEnabled = !result.isError
        if result.isError {
            errorTextLabel.text = result.message
            emailTF.shake(times: 3, delta: 5)
        } else {errorTextLabel.text = ""}
    }
    
    @objc func goToRecoveryPassword() {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        model = UserEmailModel(email: emailTF.text!)
        ApiServiceAdapter.shared.passwordRecovery(model: model!, delegate: self)
    }
    
    func resultOfPassordRecovery(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        if result.isError {
            errorTextLabel.text = result.message
            emailTF.shake(times: 3, delta: 5)
        } else {
            AlertControllerHelper.shared.show(
                title: "Успех!",
                mesg: result.message,
                form: self) { (UIAlertAction) in
                    self.delegate?.navigateToSingInPage()
            }
        }
    }
}
