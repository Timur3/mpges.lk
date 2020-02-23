//
//  SingUpCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 20.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class SingUpCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
    weak var delegateUser: SingUpViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let singUpViewController : SingUpViewController = SingUpViewController()
        singUpViewController.delegate = self
        self.navigationController.pushViewController(singUpViewController, animated: true)
    }
}
extension SingUpCoordinator: SingUpViewControllerDelegate {   
    // Navigate to next page
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}
