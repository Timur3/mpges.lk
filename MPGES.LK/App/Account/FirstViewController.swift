//
//  LoginViewController.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    public weak var delegate: MainCoordinatorDelegate?

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        navigationItem.title = "Главное"
        super.viewDidLoad()
        loginBtn.Circle()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //delegate?.childDidFinish(self)
    }
    @IBAction func authBtn(_ sender: Any) {
        delegate?.navigateToSingInPage()
    }
    @IBAction func registrBtn(_ sender: Any) {
        delegate?.navigateToSingUpPage()
    }
}
