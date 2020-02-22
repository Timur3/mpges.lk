//
//  LoginViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol FirstViewControllerDelegate: class {
    func navigateToSingInPage()
    func navigateToSingUpPage()
}

class FirstViewController: UIViewController {
    
    public weak var delegate: FirstViewControllerDelegate?

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        navigationItem.title = "Главное"
        super.viewDidLoad()
        loginBtn.Circle()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func authBtn(_ sender: Any) {
        self.delegate?.navigateToSingInPage()
    }
    @IBAction func registrBtn(_ sender: Any) {
        self.delegate?.navigateToSingUpPage()
    }
}
