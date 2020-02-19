//
//  AuthCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 18.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit
protocol BackToLoginViewControllerDelegate: class {
    func navigateBackToLoginPage(newOrderCoordinator: SingInCoordinator)
}

class SingInCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    weak var delegate: BackToLoginViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let singInViewController : SingInViewController = SingInViewController()
        singInViewController.delegate = self
        self.navigationController.viewControllers = [singInViewController]
    }
}

extension SingInCoordinator: SingInViewControllerDelegate {
    // Navigate to next page
    func navigateToLoginPage() {
       let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        //loginCoordinator.delegate = self
       childCoordinators.append(loginCoordinator)
       loginCoordinator.start()
    }
    func navigateToRecoveryPasswordPage() {
        
    }
}
