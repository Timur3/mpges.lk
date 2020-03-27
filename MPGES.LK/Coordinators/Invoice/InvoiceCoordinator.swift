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

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let invoiceTV: InvoicesTableViewController = InvoicesTableViewController(nibName: "InvoicesTableViewController", bundle: nil)
        invoiceTV.delegate = self
        self.navigationController.pushViewController(invoiceTV, animated: true)
    }
    

}
extension InvoiceCoordinator: InvoicesTableViewControllerDelegate {
    func navigantionInvoiceDetailsInfoPage() {
            let invoiceDetailsInfoCoordinator = InvoiceDetailsInfoCoordinator(navigationController: navigationController)
            //contractAddCoordinator.delegate = self
            childCoordinators.append(invoiceDetailsInfoCoordinator)
            invoiceDetailsInfoCoordinator.start()
    }
}
