//
//  RecoveryPasswordViewController.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var sendPassword: UIButton!
    @IBAction func sendBtn(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendPassword.Circle()
        // Do any additional setup after loading the view.
    }
}
