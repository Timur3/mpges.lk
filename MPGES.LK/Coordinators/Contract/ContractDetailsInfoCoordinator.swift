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
        ApiServiceAdapter.shared.getContractById(delegate: contractDetailsInfo)
        contractDetailsInfo.delegate = self
        self.navigationController.pushViewController(contractDetailsInfo, animated: true)
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

extension ContractDetailsInfoCoordinator: ContractDetailsInfoTVControllerDelegate {
    func navigationDevileryOfInvoicePage() {
        let devileryOfInvoiceCoordinator = MainDeliveryOfInvoiceCoordinator(navigationController: navigationController)
        devileryOfInvoiceCoordinator.parentCoordinator = self
        childCoordinators.append(devileryOfInvoiceCoordinator)
        devileryOfInvoiceCoordinator.start()
    }
    
    func navigationToInvoicePage() {
        let dataSend = UserDataService.shared.getCurrentContract()
        let invoiceCoordinator = InvoiceCoordinator(navigationController: navigationController)
        childCoordinators.append(invoiceCoordinator)
        invoiceCoordinator.start()
    }
    
    func navigationDevicesPage() {
        let dataSend = UserDataService.shared.getCurrentContract()
        let deviceCoordinator = MainDeviceCoordinator(navigationController: navigationController)
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
