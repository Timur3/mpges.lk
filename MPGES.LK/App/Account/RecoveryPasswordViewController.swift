//
//  RecoveryPasswordViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendPassword: UIButton!
    
    @IBAction func cancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
