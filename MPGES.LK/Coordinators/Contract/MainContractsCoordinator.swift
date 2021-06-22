//
//  ContractsListCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class MainContractsCoordinator: Coordinator {
    private var userDataService = UserDataService()
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contractsVC : ContractsTVController = ContractsTVController()
        contractsVC.tabBarItem = UITabBarItem(title: "Мои услуги", image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        contractsVC.delegate = self
        self.navigationController.viewControllers = [contractsVC]
    }
    
    func childDidFinish(_ child: Coordinator){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension MainContractsCoordinator: ContractsTVControllerDelegate {
    
    func navigationContractAddTVPage(delegate: ContractsTVControllerUserDelegate) {
        let contractAddFirstPageTVController : ContractAddTVController = ContractAddTVController()
        contractAddFirstPageTVController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: contractAddFirstPageTVController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
        
    func navigationDetailsInfoPage(to contractId: Int) {
        let contractDetailsInfoCoordinator = ContractDetailsInfoCoordinator(navigationController: navigationController)
        contractDetailsInfoCoordinator.contractId = contractId
        childCoordinators.append(contractDetailsInfoCoordinator)
        contractDetailsInfoCoordinator.start()
    }
}
