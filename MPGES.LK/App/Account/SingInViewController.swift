//
//  ViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol SingInViewControllerDelegate: class {
    func navigateToLoginPage()
    func navigateToRecoveryPasswordPage()
}

class SingInViewController: UIViewController {

    public weak var delegate: SingInViewControllerDelegate?
    
    let userDataService = UserDataService()
    let apiService = ApiService()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func authButton(_ sender: Any) {
        debugPrint("authButton press")
        ActivityIndicatorViewService.shared.showView(form: self.view)
        let modelAuth = AuthModel(email: emailTF.text!, password: passwordTF.text!)
        apiService.authApi(model: modelAuth, completion: save(modelResult:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage (named: "Card")
        imageView.image = image
        emailTF.leftView = imageView
        emailTF.leftViewMode = .always
    }

    override func viewDidLoad() {
        navigationItem.title = "Вход"
        super.viewDidLoad()
        //submitBtn.Circle()
        // Do any additional setup after loading the view.
        
    }
    
    func save(modelResult: AuthResultModel) {
        ActivityIndicatorViewService.shared.hideView()

        if !modelResult.isError {
            userDataService.setToken(token: modelResult.data!)
            performSegue(withIdentifier: "ToMainTabBar", sender: self)
            navigationController?.isNavigationBarHidden = true
        } else {
            passwordTF.shake(times: 3, delta: 5)
            errorLabel.text = modelResult.errorMessage ?? "Неизвестная ошибка"
        }
    }


}

