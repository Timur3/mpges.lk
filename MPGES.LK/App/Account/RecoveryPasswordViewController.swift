//
//  RecoveryPasswordViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol RecoveryPasswordViewControllerUserDelegate: class {
    func goToRecoveryPassword()
    func resultOfCheckEmail(result: ServerResponseModel)
    func resultOfPassordRecovery(result: ServerResponseModel)
}

class RecoveryPasswordViewController1: UIViewController {
    public weak var delegate: MainCoordinatorDelegate?
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendPassword: UIButton!
    @IBOutlet weak var errorTextLabel: UILabel!

    private var model: UserEmailModel?

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
        super.viewDidLoad()
        configuration()
    }
}
extension RecoveryPasswordViewController1: RecoveryPasswordViewControllerUserDelegate {
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
        //ApiServiceAdapter.shared.passwordRecovery(model: model!, delegate: self)
    }
    
    func resultOfPassordRecovery(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        if result.isError {
            errorTextLabel.text = result.message
            emailTF.shake(times: 3, delta: 5)
        } else {
            AlertControllerAdapter.shared.show(
                title: "Успех!",
                mesg: result.message,
                form: self) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension RecoveryPasswordViewController1 {
    private func configuration() {
        self.sendPassword.addTarget(self, action: #selector(goToRecoveryPassword), for: .touchUpInside)
        self.sendPassword.Circle()
        self.sendPassword.isEnabled = false
        
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
