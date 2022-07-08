//
//  MainTabCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 09.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public weak var mainCoordinator: MainCoordinator?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarVC: MainTabBarViewController = MainTabBarViewController()
        mainTabBarVC.delegateUser = self
        mainTabBarVC.email = ""
        // MARK: - Contracts
        let contractsNC = UINavigationController()
        contractsNC.navigationBar.isTranslucent = true
        contractsNC.navigationBar.prefersLargeTitles = true
        //contractsNC.isNavigationBarHidden = false
        //let contractsVC = ContractsTVController(nibName: "ContractsTVController", bundle: nil)
        //contractsVC.delegate = ContractsListCoordinator(navigationController: contractsNC)
        //contractsVC.tabBarItem = UITabBarItem(title: "Мои услуги", image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        let contractsListCoordinator = MainContractsCoordinator(navigationController: contractsNC)
        childCoordinators.append(contractsListCoordinator)
        contractsListCoordinator.start()
        //contractsNC.viewControllers = [contractsVC]
        
        // MARK: - Offices
        let officesVC = MapViewController(nibName: "MapViewController", bundle: nil)
        
        officesVC.tabBarItem = UITabBarItem(title: "Офисы", image: UIImage(systemName: "mappin.and.ellipse"), tag: 1)
        
        // MARK: - Profile
        let profileNC = UINavigationController()
        profileNC.navigationBar.isTranslucent = true
        profileNC.navigationBar.prefersLargeTitles = true
        
        let profileCoordinator = ProfileCoordinator(navigationController: profileNC)
        profileCoordinator.mainCoordinator = mainCoordinator
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
        
        // MARK: - Заявки и обращения
        /*let applicationNC = UINavigationController()
        applicationNC.navigationBar.isTranslucent = true
        applicationNC.navigationBar.prefersLargeTitles = true
        
        let applicationCoordinator = ProfileCoordinator(navigationController: applicationNC)
        profileCoordinator.mainCoordinator = mainCoordinator
        childCoordinators.append(applicationCoordinator)
        applicationCoordinator.start()*/
        
        
        let tabBarList = [contractsNC, officesVC, profileNC/*, applicationNC*/]
        
        mainTabBarVC.viewControllers = tabBarList
        //mainTabBarVC.delegate = self
        mainTabBarVC.delegateUser = self
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(mainTabBarVC, animated: true)
    }
}

extension MainTabBarCoordinator: MainTabBarViewControllerDelegate {
    func navigateToContractsPage() {
        print("nav main")
    }
    
    func navigateToOfficesPage() {
        print("nav office")
    }
    
    func navigateToProfilePage() {
        print("nav profile")
    }   
}
