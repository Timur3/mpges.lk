//
//  ContractsListCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractsListCoordinator: Coordinator {
    private var userDataService = UserDataService()
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contractsVC : ContractsListTVController = ContractsListTVController(nibName: "ContractsListTVController", bundle: nil)
        contractsVC.tabBarItem = UITabBarItem(title: "Мои услуги", image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        contractsVC.delegate = self
        self.navigationController.viewControllers = [contractsVC]
    }
}

extension ContractsListCoordinator: ContractsListTVControllerDelegate {
    func navigationDetailsInfoPage(model: ContractModel) {
        userDataService.setCurrentContract(contract: model)
        
        let contractDetailsInfoCoordinator = ContractDetailsInfoCoordinator(navigationController: navigationController)
        //contractDetailsInfoCoordinator.delegate = self
        childCoordinators.append(contractDetailsInfoCoordinator)
        contractDetailsInfoCoordinator.start()
    }
    
    func navigationAddPage() {
        let contractAddCoordinator = ContractAddCoordinator(navigationController: navigationController)
        //contractAddCoordinator.delegate = self
        childCoordinators.append(contractAddCoordinator)
        contractAddCoordinator.start()
    }
}
