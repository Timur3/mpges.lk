//
//  ContractAddCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractAddCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    //weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contractAddViewController : ContractAddViewController = ContractAddViewController(nibName: "ContractAddViewController", bundle: nil)
        contractAddViewController.delegate = self
        let navContractAddViewController: UINavigationController = UINavigationController(rootViewController: contractAddViewController)
        self.navigationController.present(navContractAddViewController, animated: true, completion: nil)
        //self.navigationController.pushViewController(contractAddViewController, animated: true)
    }
}

extension ContractAddCoordinator: ContractAddViewControllerDelegate {
    func navigateToBackPage() {
        
        navigationController.popViewController(animated: true)
        //self.dismissViewControllerAnimated(true, completion: nil)
        //ApiServiceAdapter.shared.getContracts(delegate: )
        //childCoordinators.removeLast()
    }
}
