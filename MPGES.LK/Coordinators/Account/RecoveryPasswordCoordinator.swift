//
//  RecoveryPassCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 20.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class RecoveryPasswordCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let recoveryPasswordViewController : RecoveryPasswordViewController = RecoveryPasswordViewController()
        //recoveryPasswordViewController.delegate = self
        let navRecoveryPasswordViewController: UINavigationController = UINavigationController(rootViewController: recoveryPasswordViewController)
        self.navigationController.present(navRecoveryPasswordViewController, animated: true, completion: nil)
    }
}
