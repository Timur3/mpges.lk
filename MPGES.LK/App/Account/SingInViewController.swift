//
//  ViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

class SingInViewController: UIViewController {
    
    let userDataService = UserDataService()
    let apiService = ApiService()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func authButton(_ sender: Any) {
        
        debugPrint("authButton press")
        let modelAuth = AuthModel(email: emailTF.text!, password: passwordTF.text!)
        
        apiService.authApi(model: modelAuth, completion: save(modelResult:))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.Circle()
        // Do any additional setup after loading the view.
        
    }
    
    func save(modelResult: AuthResultModel) {
        
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

