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

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarVC = UITabBarController()

        // MARK: - Contracts
        let contractsNC = UINavigationController()
        contractsNC.navigationBar.isTranslucent = true
        contractsNC.navigationBar.prefersLargeTitles = true
        
        //let contractsVC = ContractsListTVController(nibName: "ContractsListTVController", bundle: nil)
        //contractsVC.delegate = ContractsListCoordinator(navigationController: contractsNC)
        //contractsVC.tabBarItem = UITabBarItem(title: "Мои услуги", image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        let contractsListCoordinator = ContractsListCoordinator(navigationController: contractsNC)
        childCoordinators.append(contractsListCoordinator)
        contractsListCoordinator.start()
        //contractsNC.viewControllers = [contractsVC]
        
        // MARK: - Offices
        let officesVC = OfficesViewController(nibName: "OfficesViewController", bundle: nil)

        officesVC.tabBarItem = UITabBarItem(title: "Офисы", image: UIImage(systemName: "mappin.and.ellipse"), tag: 1)

        // MARK: - Profile
        let profileNC = UINavigationController()
        profileNC.navigationBar.isTranslucent = true
        profileNC.navigationBar.prefersLargeTitles = true
       
        let profileCoordinator = ProfileCoordinator(navigationController: profileNC)
        
        profileCoordinator.start()
        
        let tabBarList = [contractsNC, officesVC, profileNC]

        mainTabBarVC.viewControllers = tabBarList
        //mainTabBarVC.delegate = self
        //mainTabBarVC.delegateUser = self
        
        self.navigationController.pushViewController(mainTabBarVC, animated: true)
    }
}

extension MainTabBarCoordinator: MainTabBarViewControllerDelegate {
    func navigateToContractsPage() {
        
    }
    
    func navigateToOfficesPage() {
        
    }
    
    func navigateToProfilePage() {
        
    }   
}
