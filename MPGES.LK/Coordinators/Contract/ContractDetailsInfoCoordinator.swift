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
    func navigateToPayWithSberbankOnlinePage() {
        let payWithSberbankOnlinePageTVController : PayWithSberbankOnlineTVController = PayWithSberbankOnlineTVController()
        payWithSberbankOnlinePageTVController.delegate = self
        let navPayWithSberbankOnlinePageTVController: UINavigationController = UINavigationController(rootViewController: payWithSberbankOnlinePageTVController)
        self.navigationController.present(navPayWithSberbankOnlinePageTVController, animated: true, completion: nil)
    }
    
    
    func navigateToPayWithCreditCardPage() {
        let payWithCreditCardPageTVController : PayWithCreditCardViewController = PayWithCreditCardViewController()
        payWithCreditCardPageTVController.delegate = self
        let navPayWithCreditCardPageTVController: UINavigationController = UINavigationController(rootViewController: payWithCreditCardPageTVController)
        self.navigationController.present(navPayWithCreditCardPageTVController, animated: true, completion: nil)
    }
    
    func navigationToContractorInfoPage() {
        let contractorInfoPageTVController : ContractorInfoTVController = ContractorInfoTVController()
        //contractorInfoPageTVController.delegate = delegate
        let navContractorInfoPageTVController: UINavigationController = UINavigationController(rootViewController: contractorInfoPageTVController)
        self.navigationController.present(navContractorInfoPageTVController, animated: true, completion: nil)
    }
    
    // Ппереход на страницу способы доставки квитанций
    func navigationInvoiceDevileryMethodPage(for contract: ContractModel, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        let devileryOfInvoiceTV: DeliveryMethodTVController = DeliveryMethodTVController()
        devileryOfInvoiceTV.contract = contract
        devileryOfInvoiceTV.delegate = delegate
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
