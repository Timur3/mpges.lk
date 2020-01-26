//
//  ProfileViewController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let userData = UserDataService()
    
    @IBAction func exitButton(_ sender: Any) {
        debugPrint("exitB press")
        performSegue(withIdentifier: "GoToMain", sender: self)
        userData.delData()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
