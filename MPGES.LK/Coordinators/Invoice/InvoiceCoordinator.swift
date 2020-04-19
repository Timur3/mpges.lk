//
//  CalculationCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 19.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class InvoiceCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public var contract: ContractModel?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let invoiceTV: InvoicesTableViewController = InvoicesTableViewController()
        invoiceTV.delegate = self
        invoiceTV.contractId = contract!.id
        self.navigationController.pushViewController(invoiceTV, animated: true)
    }
    

}
extension InvoiceCoordinator: InvoicesTableViewControllerDelegate {
    func navigantionInvoiceDetailsInfoPage(model: InvoiceModel) {
        let invoiceDetailsInfoTV: InvoiceDetailsInfoTableViewController = InvoiceDetailsInfoTableViewController()
        invoiceDetailsInfoTV.invoice = model
        self.navigationController.pushViewController(invoiceDetailsInfoTV, animated: true)
    }
}
