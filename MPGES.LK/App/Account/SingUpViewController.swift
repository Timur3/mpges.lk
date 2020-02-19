//
//  SingUpViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitSingUP: UIButton!
    @IBAction func submitBtn(_ sender: Any) {
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        navigationItem.title = "Регистрация"
        super.viewDidLoad()
        submitSingUP.Circle()
    }
}
