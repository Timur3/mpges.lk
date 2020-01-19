//
//  ViewController.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

class SingInViewController: UIViewController {
    
    let _ud = UserDataService()
    let _api = ApiService()
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func AuthButton(_ sender: Any) {
        debugPrint("authButton press")
        let modelAuth = AuthModel(email: emailTF.text!, password: passwordTF.text!)
        
        _api.authApi(model: modelAuth, completion: save(modelResult:))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func save(modelResult: AuthResultModel) {
       
        let m = modelResult
        if m.isError == false {
            _ud.saveData(token: m.data!, userId: 1)
            performSegue(withIdentifier: "ToMainTabBar", sender: self)
            self.navigationController?.isNavigationBarHidden = true
        } else {
            passwordTF.shake(times: 5, delta: 5)
            debugPrint(m.errorMessage ?? "")
        }
    }


}

