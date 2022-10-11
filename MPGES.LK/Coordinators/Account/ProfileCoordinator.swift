//
//  ProfileCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 01.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    public weak var mainCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC: ProfileTVController = ProfileTVController()
        profileVC.tabBarItem = UITabBarItem(title: "Больше", image: UIImage(systemName: "ellipsis.circle"), tag: 2)
        profileVC.navigationItem.title = NSLocalizedString("title.more", comment: "Больше")
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
        let changePasswordVC : PasswordChangeTVController = PasswordChangeTVController()
        changePasswordVC.delegateProfile = self
        let navChangePasswordVC: UINavigationController = UINavigationController(rootViewController: changePasswordVC)
        self.navigationController.present(navChangePasswordVC, animated: true, completion: nil)
    }
    
    func navigationPasswordPage() {
        let changePasswordVC : PasswordChangeTVController = PasswordChangeTVController()
        changePasswordVC.delegateProfile = self
        let navChangePasswordVC: UINavigationController = UINavigationController(rootViewController: changePasswordVC)
        self.navigationController.present(navChangePasswordVC, animated: true, completion: nil)
    }
    
    func navigateToFirstPage() {
        mainCoordinator?.navigateToFirstPage()
    }
    
    func navigationToMailSend() {
        
    }
    
    func navigationToPageEnterCode() {
        let pageEnterCodeVC : PageEnterCodeTVController = PageEnterCodeTVController()
        pageEnterCodeVC.navigationItem.title = NSLocalizedString("title.deletedAccount", comment: "Удаление")
        pageEnterCodeVC.delegateProfile = self
        let navPageEnterCodeVC: UINavigationController = UINavigationController(rootViewController: pageEnterCodeVC)
        self.navigationController.present(navPageEnterCodeVC, animated: true, completion: nil)
    }
}
