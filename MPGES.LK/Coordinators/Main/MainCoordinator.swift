//
//  LoginCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 18.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: class {
    func navigateToSignInPage()
    func navigateToSignUpPage()
    func navigateToFirstPage()
    func navigateToRecoveryPasswordPage()
    func goToNextSceneApp()
    func childDidFinish(_ child: Coordinator)
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if (true) {
            let firstViewController : FirstTVController = FirstTVController()
            firstViewController.delegate = self
            self.navigationController.viewControllers = [firstViewController]
        } else
        {
            let mainTabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
            mainTabBarCoordinator.delegate = self
            childCoordinators.append(mainTabBarCoordinator)
            mainTabBarCoordinator.start()
        }
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func childDidFinish(_ child: Coordinator){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    // Переход на страницу входа
    func navigateToSignInPage() {
       let signInViewController : SignInTVController = SignInTVController()
       signInViewController.delegate = self
       self.navigationController.pushViewController(signInViewController, animated: true)
    }
    
    func navigateToFirstPage() {
        let firstViewController : FirstTVController = FirstTVController()
        firstViewController.delegate = self
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.viewControllers = [firstViewController]
        //self.navigationController
        self.childCoordinators.removeAll()
    }
    
    func navigateToRecoveryPasswordPage() {
        let recoveryPasswordViewController : RecoveryPasswordTVController = RecoveryPasswordTVController()
        let navRecoveryPasswordViewController: UINavigationController = UINavigationController(rootViewController: recoveryPasswordViewController)
        self.navigationController.present(navRecoveryPasswordViewController, animated: true, completion: nil)
    }
    
    func goToNextSceneApp() {
        let mainTabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        mainTabBarCoordinator.delegate = self
        childCoordinators.append(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
    }
    
    func navigateToSignUpPage() {
        let signUpTVController : SignUpTVController = SignUpTVController()
        let navSignUpTVController: UINavigationController = UINavigationController(rootViewController: signUpTVController)
        self.navigationController.present(navSignUpTVController, animated: true, completion: nil)
    }
}
