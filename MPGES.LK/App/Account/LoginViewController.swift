//
//  LoginViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol LoginViewControllerDelegate: class {
    func navigateToSingInPage()
}

class LoginViewController: UIViewController {
    
    public weak var delegate: LoginViewControllerDelegate?

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        navigationItem.title = ""
        super.viewDidLoad()
        //loginBtn.Circle()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func AuthBtn(_ sender: Any) {
        self.delegate?.navigateToSingInPage()
    }
}
