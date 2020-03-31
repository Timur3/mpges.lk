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
        let contractsVC : ContractsTVController = ContractsTVController(nibName: "ContractsTVController", bundle: nil)
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
    
    func navigationDetailsInfoPage(to contract: ContractModel) {
        
        //let contractDetailsInfo: ContractDetailsInfoTVController = ContractDetailsInfoTVController(nibName: "ContractDetailsInfoTVController", bundle: nil)
        //contractDetailsInfo.contractModel = contract
        //ApiServiceAdapter.shared.getContractById(delegate: contractDetailsInfo)
        //contractDetailsInfo.delegate = self
        //self.navigationController.pushViewController(contractDetailsInfo, animated: true)
        
        userDataService.setCurrentContract(contract: contract)
        
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
