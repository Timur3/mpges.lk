//
//  ProfileCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 01.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: MainCoordinator?
    
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
        let emailToDevCoordinator = EmailToDeveloperCoordinator(navigationController: navigationController)
        //navigationChangePasswordPage.delegate = self
        childCoordinators.append(emailToDevCoordinator)
        emailToDevCoordinator.start()
    }
    
    func navigationChangePasswordPage() {
        let changePasswordCoordinator = ChangePasswordCoordinator(navigationController: navigationController)
        //navigationChangePasswordPage.delegate = self
        childCoordinators.append(changePasswordCoordinator)
        changePasswordCoordinator.start()
    }
    
    func navigateToFirstPage() {
        delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}
