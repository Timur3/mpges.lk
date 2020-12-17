//
//  ProfileCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 01.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    public weak var delegate: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
   
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC: ProfileTVController = ProfileTVController()
        profileVC.tabBarItem = UITabBarItem(title: "Больше", image: UIImage(systemName: "ellipsis.circle"), tag: 2)
        profileVC.delegate = self
        self.navigationController.pushViewController(profileVC, animated: true)
    }
}
extension ProfileCoordinator: ProfileTVControllerDelegate {
    
    func navigationAboutPage() {
        let aboutTVController : AboutTableViewController = AboutTableViewController()
        aboutTVController.delegate = self
        let navAboutTVContoller: UINavigationController = UINavigationController(rootViewController: aboutTVController)
        self.navigationController.present(navAboutTVContoller, animated: true, completion: nil)
    }
    
    func navigationEmailToDeveloperPage() {
        let emailToDeveloperTV : EmailToDeveloperTVController = EmailToDeveloperTVController()
        emailToDeveloperTV.delegate = self
        let navEmailToDevVC: UINavigationController = UINavigationController(rootViewController: emailToDeveloperTV)
        self.navigationController.present(navEmailToDevVC, animated: true, completion: nil)
    }
    
    func navigationChangePasswordPage() {
        let changePasswordVC : ChangePasswordTVController = ChangePasswordTVController()
        changePasswordVC.delegateProfile = self
        let navChangePasswordVC: UINavigationController = UINavigationController(rootViewController: changePasswordVC)
        self.navigationController.present(navChangePasswordVC, animated: true, completion: nil)    }
    
    func navigateToFirstPage() {
        delegate?.navigateToFirstPage()
    }
    
    func navigationToMailSend() {
        
    }
}
