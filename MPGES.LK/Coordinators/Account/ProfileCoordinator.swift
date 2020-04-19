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
        let profileVC: ProfileTVController = ProfileTVController(nibName: "ProfileTableViewController", bundle: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Еще", image: UIImage(systemName: "ellipsis.circle"), tag: 2)
        profileVC.delegate = self
        self.navigationController.pushViewController(profileVC, animated: true)
    }
    

}
extension ProfileCoordinator: ProfileTVControllerDelegate {
    func navigationEmailToDeveloperPage() {
        let emailToDevVC : EmailToDeveloperViewController = EmailToDeveloperViewController()
        emailToDevVC.delegate = self
        let navEmailToDevVC: UINavigationController = UINavigationController(rootViewController: emailToDevVC)
        self.navigationController.present(navEmailToDevVC, animated: true, completion: nil)
    }
    
    func navigationChangePasswordPage() {
        let changePasswordVC : ChangePasswordViewController = ChangePasswordViewController()
        changePasswordVC.delegate = self
        let navChangePasswordVC: UINavigationController = UINavigationController(rootViewController: changePasswordVC)
        self.navigationController.present(navChangePasswordVC, animated: true, completion: nil)    }
    
    func navigateToFirstPage() {
        delegate?.navigateToFirstPage()
    }
}
