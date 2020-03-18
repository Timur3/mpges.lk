//
//  SingUpViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingUpViewControllerDelegate: class {
    func navigateToFirstPage()
}
public protocol SingUpViewControllerUserDelegate: class {
    func createUser(user: UserModel)
    func resultOfCreateUser(result: ServerResponseModel)
}

class SingUpViewController: UIViewController {

    public weak var delegate: SingUpViewControllerDelegate?
    public weak var delegateUser: SingUpViewControllerUserDelegate?
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitSingUP: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func submitBtn(_ sender: Any) {
        if (fullNameTF.text!.isEmpty){
            errorLabel.text = "Введите Ваше имя"
            fullNameTF.shake(times: 3, delta: 5)
        } else
            if (!isValidEmail(emailTF.text!) || emailTF.text!.isEmpty) {
                errorLabel.text = "Не верный формат электронной почты"
                emailTF.shake(times: 3, delta: 5)
            } else {
                let user = UserModel(Id: 0, Name: fullNameTF.text!, Password: passwordTF.text!, PasswordHash: "", Email: emailTF.text!, Mobile: "", IsOnline: false, Confirmed: false, CreateDate: "\(NSDate.now)", RoleId: 3)
                self.delegateUser?.createUser(user: user)
        }
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.delegate?.navigateToFirstPage()
    }
    
    
    override func viewDidLoad() {
        navigationItem.title = "Регистрация"
        passwordTF.isSecureTextEntry = true
        super.viewDidLoad()
        submitSingUP.Circle()
        delegateUser = self
    }
}

extension SingUpViewController: SingUpViewControllerUserDelegate {
    
    func resultOfCreateUser(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        if result.isError {
            errorLabel.text = result.message
            passwordTF.shake(times: 3, delta: 5)
        } else {
            AlertControllerHelper.shared.show(
                title: "Успех!",
                mesg: result.message,
                form: self) { (UIAlertAction) in
                    self.delegate?.navigateToFirstPage()
            }
        }
    }

    func createUser(user: UserModel) {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        ApiServiceAdapter.shared.createUser(model: user, delegate: self)
    }
}
