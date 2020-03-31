//
//  ContractAddCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol ContractAddViewControllerDelegate: class {
    func didFinishPage()
}

class ContractAddCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    weak var parentCoordinator: MainContractsCoordinator?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contractAddViewController : ContractAddViewController = ContractAddViewController(nibName: "ContractAddViewController", bundle: nil)
        contractAddViewController.delegate = self
        let navContractAddViewController: UINavigationController = UINavigationController(rootViewController: contractAddViewController)
        self.navigationController.present(navContractAddViewController, animated: true, completion: nil)
    }
    

}
extension ContractAddCoordinator: ContractAddViewControllerDelegate {
    func didFinishPage(){
        //todo обновить список договоров
        parentCoordinator?.childDidFinish(self)
    }
}
