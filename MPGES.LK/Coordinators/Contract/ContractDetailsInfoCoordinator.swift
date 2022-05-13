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
    public var contractId: Int = 0
    
    func start() {
        let contractDetailsInfo: ContractDetailsInfoTVController = ContractDetailsInfoTVController()
        contractDetailsInfo.delegate = self
        contractDetailsInfo.contractId = contractId
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
    func navigateToPayWithTinkoffPage(model: BankPayModel, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        let payWithTinkoffTVController : PayWithTinkoffViewController = PayWithTinkoffViewController()
        payWithTinkoffTVController.contractDelegate = delegate
        payWithTinkoffTVController.model = model
        let navPayWithTinkoffTVController: UINavigationController = UINavigationController(rootViewController: payWithTinkoffTVController)
        navPayWithTinkoffTVController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navPayWithTinkoffTVController, animated: true, completion: nil)
    }
    
    
    func navigateToPayWithApplePayPage(model: BankPayModel, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        let payWithApplePayTVController : PayWithApplePayTVController = PayWithApplePayTVController()
        payWithApplePayTVController.contractDelegate = delegate
        payWithApplePayTVController.model = model
        let navPayWithApplePayTVController: UINavigationController = UINavigationController(rootViewController: payWithApplePayTVController)
        self.navigationController.present(navPayWithApplePayTVController, animated: true, completion: nil)
    }
    
    func navigateToPayWithSberbankOnlinePage(model: BankPayModel) {
        let payWithSberbankOnlinePageTVController : PayWithSberbankOnlineTVController = PayWithSberbankOnlineTVController()
        payWithSberbankOnlinePageTVController.delegate = self
        payWithSberbankOnlinePageTVController.model = model
        let navPayWithSberbankOnlinePageTVController: UINavigationController = UINavigationController(rootViewController: payWithSberbankOnlinePageTVController)
        self.navigationController.present(navPayWithSberbankOnlinePageTVController, animated: true, completion: nil)
    }
    
    
    func navigateToPayWithCreditCardPage() {
        let payWithCreditCardPageTVController : PayWithCreditCardViewController = PayWithCreditCardViewController()
        payWithCreditCardPageTVController.delegate = self
        let navPayWithCreditCardPageTVController: UINavigationController = UINavigationController(rootViewController: payWithCreditCardPageTVController)
        self.navigationController.present(navPayWithCreditCardPageTVController, animated: true, completion: nil)
    }
    
    func navigationToContractorInfoPage(for contractor: ContractorModel) {
        let contractorInfoPageTVController : ContractorInfoTVController = ContractorInfoTVController()
        contractorInfoPageTVController.contractor = contractor
        let navContractorInfoPageTVController: UINavigationController = UINavigationController(rootViewController: contractorInfoPageTVController)
        self.navigationController.present(navContractorInfoPageTVController, animated: true, completion: nil)
    }
    
    // Ппереход на страницу способы доставки квитанций
    func navigationInvoiceDevileryMethodPage(for contract: ContractModel, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        let devileryOfInvoiceTV = InvoiceDeliveryMethodsViewController()
        devileryOfInvoiceTV.contract = contract
        devileryOfInvoiceTV.delegate = delegate
        self.navigationController.pushViewController(devileryOfInvoiceTV, animated: true)
    }
    
    func didFinishDeliveryMethodPage(for invoiceDeliveryMethod: InvoiceDeliveryMethodModel){
        
    }
    
    func navigationToInvoicePage() {
        let invoiceCoordinator = InvoiceCoordinator(navigationController: navigationController)
        invoiceCoordinator.contractId = contractId
        childCoordinators.append(invoiceCoordinator)
        invoiceCoordinator.start()
    }
    
    func navigationDevicesPage() {
        let deviceCoordinator = DeviceCoordinatorMain(navigationController: navigationController)
        deviceCoordinator.contractId = contractId
        childCoordinators.append(deviceCoordinator)
        deviceCoordinator.start()
    }
    
    func navigateToPaymentsPage() {
        let paymentCoordinator = PaymentCoordinator(navigationController: navigationController)
        paymentCoordinator.contractId = contractId
        childCoordinators.append(paymentCoordinator)
        paymentCoordinator.start()
    }
    
    func navigateToBackPage() {
        
    }
        
    func navigationToResultOfPayment(for model: ResultModel<Double>) {
        let resultOfPay: ResultOfPaymentTableViewController = ResultOfPaymentTableViewController()
        //resultOfPay.delegate = self
        resultOfPay.resultPay = model
        let navResultOfPay: UINavigationController = UINavigationController(rootViewController: resultOfPay)
        self.navigationController.present(navResultOfPay, animated: true, completion: nil)
        ActivityIndicationService.shared.hideView()
    }
}
