//
//  ContractDetailsInfoCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 14.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractDetailsInfoCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contractDetailsInfo: ContractDetailsInfoTVController = ContractDetailsInfoTVController(nibName: "ContractDetailsInfoTVController", bundle: nil)
        contractDetailsInfo.delegate = self
        self.navigationController.pushViewController(contractDetailsInfo, animated: true)
    }
}

extension ContractDetailsInfoCoordinator: ContractDetailsInfoTVControllerDelegate {
    func navigationDevicesPage() {
        let dataSend = UserDataService.shared.getCurrentContract()
        let deviceCoordinator = DeviceCoordinator(navigationController: navigationController)
        childCoordinators.append(deviceCoordinator)
        deviceCoordinator.start()
    }
    
    func navigateToPaymentsPage() {
        let dataSend = UserDataService.shared.getCurrentContract()
        let paymentCoordinator = PaymentCoordinator(navigationController: navigationController)
        childCoordinators.append(paymentCoordinator)
        paymentCoordinator.start()
    }
    
    func navigateToBackPage() {
        
    }
}
