//
//  ChangePasswordCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class ChangePasswordCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    //weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let changePasswordVC : ChangePasswordViewController = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        changePasswordVC.delegate = self
        let navChangePasswordVC: UINavigationController = UINavigationController(rootViewController: changePasswordVC)
        self.navigationController.present(navChangePasswordVC, animated: true, completion: nil)
    }
}

extension ChangePasswordCoordinator: ChangePasswordViewControllerDelegate {
    func navigateToBackPage() {
        
    }
}
