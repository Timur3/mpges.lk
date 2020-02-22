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
    //weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let recoveryPasswordViewController : RecoveryPasswordViewController = RecoveryPasswordViewController()
        recoveryPasswordViewController.delegate = self
        self.navigationController.pushViewController(recoveryPasswordViewController, animated: true)
    }
}
extension RecoveryPasswordCoordinator: RecoveryPasswordViewControllerDelegate {
    func navigateToSingInPage() {
        self.navigationController.popViewController(animated: true)
    }
    
    func goToRecoveryPassword() {
        debugPrint("press recovery pass")
    }
    
    
}
