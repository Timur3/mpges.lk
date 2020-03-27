//
//  EmailToDeveloperCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class EmailToDeveloperCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    //weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let emailToDevVC : EmailToDeveloperViewController = EmailToDeveloperViewController(nibName: "EmailToDeveloperViewController", bundle: nil)
        emailToDevVC.delegate = self
        let navEmailToDevVC: UINavigationController = UINavigationController(rootViewController: emailToDevVC)
        self.navigationController.present(navEmailToDevVC, animated: true, completion: nil)
    }
}

extension EmailToDeveloperCoordinator: EmailToDeveloperViewControllerDelegate {
    func navigateToBackPage() {
        
    }
}
