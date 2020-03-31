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
   
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let singUpViewController : SingUpViewController = SingUpViewController()
        let navSingUpViewController: UINavigationController = UINavigationController(rootViewController: singUpViewController)
        self.navigationController.present(navSingUpViewController, animated: true, completion: nil)
    }
}
