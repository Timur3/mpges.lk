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
    func goToRecoveryPassword()
}

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendPassword: UIButton!
    
    public weak var delegate: RecoveryPasswordViewControllerDelegate?
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.delegate?.navigateToSingInPage()
    }
    
    @IBAction func changeEmail(_ sender: UITextField) {
        emailTF.textColor = .red
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Восстановление пароля"
        super.viewDidLoad()
        sendPassword.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        sendPassword.Circle()
        // Do any additional setup after loading the view.
    }
    
    @objc func submitAction(sender: UIButton!) {
        
    }
}
