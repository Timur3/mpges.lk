//
//  LoginCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 18.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController : LoginViewController = LoginViewController()
        loginViewController.delegate = self
        self.navigationController.viewControllers = [loginViewController]
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    // Navigate to next page
    func navigateToSingInPage() {
       let singInCoordinator = SingInCoordinator(navigationController: navigationController)
       singInCoordinator.delegate = self
       childCoordinators.append(singInCoordinator)
       singInCoordinator.start()
    }
}

extension LoginCoordinator: BackToLoginViewControllerDelegate {
    
    // Back from third page
    func navigateBackToLoginPage(newOrderCoordinator: SingInCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
