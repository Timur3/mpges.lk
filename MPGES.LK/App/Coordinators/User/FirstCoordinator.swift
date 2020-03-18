//
//  LoginCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 18.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class FirstCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController : FirstViewController = FirstViewController(nibName: "FirstViewController", bundle: nil)
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
}

extension FirstCoordinator: FirstViewControllerDelegate {
    func navigateToSingUpPage() {
        let singUpCoordinator = SingUpCoordinator(navigationController: navigationController)
        singUpCoordinator.delegate = self
        childCoordinators.append(singUpCoordinator)
        singUpCoordinator.start()
    }
    
    // Navigate to next page
    func navigateToSingInPage() {
       let singInCoordinator = SingInCoordinator(navigationController: navigationController)
       singInCoordinator.delegate = self
       childCoordinators.append(singInCoordinator)
       singInCoordinator.start()
    }
}

extension FirstCoordinator: BackToFirstViewControllerDelegate {
    // Back from
    func navigateBackToFirstPage(newOrderCoordinator: Coordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
    
}
