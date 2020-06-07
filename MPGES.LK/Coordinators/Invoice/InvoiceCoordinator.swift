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
        let invoiceTV: InvoicesTableViewController = InvoicesTableViewController()
        invoiceTV.delegate = self
        invoiceTV.contractId = contract!.id
        self.navigationController.pushViewController(invoiceTV, animated: true)
    }
}
extension InvoiceCoordinator: InvoicesTableViewControllerDelegate {
    
    func sendDocByEmail(model: SendInvoiceModel, delegate: InvoicesTableViewControllerUserDelegate) {
        ApiServiceWrapper.shared.sendInvoiceByEmail(model: model, delegate: delegate)
    }
    
    func navigantionInvoiceDetailsInfoPage(model: InvoiceModel) {
        let invoiceDetailsInfoTV: InvoiceDetailsInfoTableViewController = InvoiceDetailsInfoTableViewController()
        invoiceDetailsInfoTV.invoice = model
        self.navigationController.pushViewController(invoiceDetailsInfoTV, animated: true)
    }
    
    func pdfView(for urlToPdfFile: URL, delegate: InvoicesTableViewControllerUserDelegate) {
        let pdfViewController: PDFViewController = PDFViewController()
        pdfViewController.urlToPdf = urlToPdfFile
        pdfViewController.delegate = delegate
        let navContractAddFirstPageTVController: UINavigationController = UINavigationController(rootViewController: pdfViewController)
        self.navigationController.present(navContractAddFirstPageTVController, animated: true, completion: nil)
    }
    
}
