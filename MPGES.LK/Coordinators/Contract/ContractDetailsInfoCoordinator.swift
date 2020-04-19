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
    public var contract: ContractModel?
    
    func start() {
        let contractDetailsInfo: ContractDetailsInfoTVController = ContractDetailsInfoTVController()
        contractDetailsInfo.delegate = self
        contractDetailsInfo.contractModel = contract
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
    // Ппереход на страницу способы доставки квитанций
    func navigationInvoiceDevileryMethodPage(for invoiceDeliveryMehtodId: Int) {
        let devileryOfInvoiceTV: DeliveryMethodTVController = DeliveryMethodTVController()
        devileryOfInvoiceTV.invoiceDeliveryMethodId = invoiceDeliveryMehtodId
        devileryOfInvoiceTV.delegate = self
        self.navigationController.pushViewController(devileryOfInvoiceTV, animated: true)
    }
    
    func didFinishDeliveryMethodPage(for invoiceDeliveryMethod: InvoiceDeliveryMethodModel){
        
    }
    
    func navigationToInvoicePage() {
        let invoiceCoordinator = InvoiceCoordinator(navigationController: navigationController)
        invoiceCoordinator.contract = contract
        childCoordinators.append(invoiceCoordinator)
        invoiceCoordinator.start()
    }
    
    func navigationDevicesPage() {
        let deviceCoordinator = DeviceCoordinatorMain(navigationController: navigationController)
        deviceCoordinator.contract = contract
        childCoordinators.append(deviceCoordinator)
        deviceCoordinator.start()
    }
    
    func navigateToPaymentsPage() {
        let paymentCoordinator = PaymentCoordinator(navigationController: navigationController)
        paymentCoordinator.contract = contract
        childCoordinators.append(paymentCoordinator)
        paymentCoordinator.start()
    }
    
    func navigateToBackPage() {
        
    }
}
