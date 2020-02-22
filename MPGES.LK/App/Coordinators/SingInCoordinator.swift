//
//  AuthCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 18.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit
protocol BackToFirstViewControllerDelegate: class {
    func navigateBackToFirstPage(newOrderCoordinator: Coordinator)
}

class SingInCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let singInViewController : SingInViewController = SingInViewController()
        singInViewController.delegate = self
        self.navigationController.pushViewController(singInViewController, animated: true)
    }
}

extension SingInCoordinator: SingInViewControllerDelegate {
    func goToNextSceneApp() {
        debugPrint("to app")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainApp") as! UITabBarController
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDemo() {
        
    }
    // Navigate to next page
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
    
    func navigateToRecoveryPasswordPage() {
        let recoveryPasswordCoordinator = RecoveryPasswordCoordinator(navigationController: navigationController)
        //recoveryPasswordCoordinator.delegate = self
        childCoordinators.append(recoveryPasswordCoordinator)
        recoveryPasswordCoordinator.start()
    }
    
}
