//
//  CalculationCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 19.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit
import PDFKit

class InvoiceCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public var contract: ContractModel?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let invoiceTV = InvoicesViewController(nibName: "InvoicesViewController", bundle: nil)
        //InvoicesTableViewController = InvoicesTableViewController()
        invoiceTV.delegate = self
        invoiceTV.contractId = contract!.id
        self.navigationController.pushViewController(invoiceTV, animated: true)
    }
}
extension InvoiceCoordinator: InvoicesViewControllerDelegate {
    
    func sendDocByEmail(model: SendInvoiceModel, delegate: InvoicesViewControllerUserDelegate) {
        ApiServiceWrapper.shared.sendInvoiceByEmail(model: model, delegate: delegate)
    }

    func pdfView(for urlToPdfFile: URL, delegate: InvoicesViewControllerUserDelegate) {
        let pdfViewController: PDFViewController = PDFViewController()
        pdfViewController.urlToPdf = urlToPdfFile
        pdfViewController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: pdfViewController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
    
}
