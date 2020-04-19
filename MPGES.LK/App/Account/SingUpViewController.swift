//
//  SingUpViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingUpViewControllerUserDelegate: class {
    func createUser(user: UserModel)
    func resultOfCreateUser(result: ServerResponseModel)
}

class SingUpViewController1: UIViewController {

    public weak var delegateUser: SingUpViewControllerUserDelegate?
    public weak var delegate: MainCoordinatorDelegate?
    
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
    
    override func viewDidLoad() {
        navigationItem.title = "Регистрация"
        super.viewDidLoad()
        configuration()
    }
}

extension SingUpViewController1: SingUpViewControllerUserDelegate {
    
    func resultOfCreateUser(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        if result.isError {
            errorLabel.text = result.message
            passwordTF.shake(times: 3, delta: 5)
        } else {
            AlertControllerAdapter.shared.show(
                title: "Успех!",
                mesg: result.message,
                form: self) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func createUser(user: UserModel) {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        ApiServiceAdapter.shared.createUser(model: user, delegate: self)
    }
}

extension SingUpViewController1 {
    private func configuration(){
        self.passwordTF.isSecureTextEntry = true
        self.submitSingUP.Circle()
        self.delegateUser = self
        
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
