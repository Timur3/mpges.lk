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

class SingUpViewController: UIViewController {

    public weak var delegate: SingUpViewControllerDelegate?
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitSingUP: UIButton!
    @IBAction func submitBtn(_ sender: Any) {
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.delegate?.navigateToFirstPage()
    }
    
    
    override func viewDidLoad() {
        navigationItem.title = "Регистрация"
        super.viewDidLoad()
        submitSingUP.Circle()
    }
}
