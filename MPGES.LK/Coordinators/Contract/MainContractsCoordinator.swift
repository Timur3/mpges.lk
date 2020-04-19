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
    func navigationContractAddPage(delegate: ContractsTVControllerUserDelegate) {
        let contractAddFirstPageTVController : ContractAddViewController = ContractAddViewController()
        contractAddFirstPageTVController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: contractAddFirstPageTVController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
    
    func navigationContractAddTVPage(delegate: ContractsTVControllerUserDelegate) {
        let contractAddFirstPageTVController : ContractAddTVController = ContractAddTVController()
        contractAddFirstPageTVController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: contractAddFirstPageTVController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
    
    
    func navigationDetailsInfoPage(to contract: ContractModel) {
        let contractDetailsInfoCoordinator = ContractDetailsInfoCoordinator(navigationController: navigationController)
        contractDetailsInfoCoordinator.contract = contract
        childCoordinators.append(contractDetailsInfoCoordinator)
        contractDetailsInfoCoordinator.start()
    }
    
    // переход на страницу Добавления договора
    func navigationContractAddFisrtPage(delegate: ContractsTVControllerUserDelegate) {
        let contractAddFirstPageTVController : ContractAddFirstPageTVController = ContractAddFirstPageTVController()
        contractAddFirstPageTVController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: contractAddFirstPageTVController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
    
    // переход на страницу Добавления договора
    func navigationContractAddPage1(delegate: ContractsTVControllerUserDelegate) {
        let contractAddViewController : ContractAddViewController = ContractAddViewController()
        contractAddViewController.delegate = delegate
        let navContractAddViewController: UINavigationController = UINavigationController(rootViewController: contractAddViewController)
        self.navigationController.present(navContractAddViewController, animated: true, completion: nil)
    }
}
