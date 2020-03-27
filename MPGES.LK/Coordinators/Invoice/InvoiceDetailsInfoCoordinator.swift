//
//  InvoiceDetailsInfoCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class InvoiceDetailsInfoCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let invoiceDetailsInfoTV: InvoiceDetailsInfoTableViewController = InvoiceDetailsInfoTableViewController(nibName: "InvoiceDetailsInfoTableViewController", bundle: nil)
        invoiceDetailsInfoTV.delegate = self
        self.navigationController.pushViewController(invoiceDetailsInfoTV, animated: true)
    }
    

}
extension InvoiceDetailsInfoCoordinator: InvoiceDetailsInfoTableViewControllerDelegate {
    func navigantionInvoicePage() {
        
    }
    
    
}
