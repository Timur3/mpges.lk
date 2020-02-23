//
//  ViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingInViewControllerDelegate: class {
    func navigateToFirstPage()
    func navigateToRecoveryPasswordPage()
    func goToNextSceneApp()
    func goToDemo()
}

class SingInViewController: UIViewController {

    public weak var delegate: SingInViewControllerDelegate?
    
    let userDataService = UserDataService()
    let apiService = ApiService()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func recoveryPassBtn(_ sender: Any) {
        self.delegate?.navigateToRecoveryPasswordPage()
    }
    
    @IBAction func authButton(_ sender: Any) {
        debugPrint("authButton press")
        ActivityIndicatorViewService.shared.showView(form: self.view)
        let modelAuth = AuthModel(email: emailTF.text!, password: passwordTF.text!)
        apiService.authApi(model: modelAuth, completion: save(modelResult:))
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Вход"
        super.viewDidLoad()
        submitBtn.Circle()
    }
    
    func save(modelResult: ResultModel) {
        ActivityIndicatorViewService.shared.hideView()

        if !modelResult.isError {
            userDataService.setToken(token: modelResult.data!)
            self.delegate?.goToNextSceneApp()
            navigationController?.isNavigationBarHidden = true
        } else {
            switch modelResult.errorCode {
            case 0:
                emailTF.shake(times: 3, delta: 5)
                errorLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
            case 1:
                passwordTF.shake(times: 3, delta: 5)
                errorLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
            default:
                emailTF.shake(times: 3, delta: 5)
                passwordTF.shake(times: 3, delta: 5)
                errorLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
            }
            
        }
    }


}

