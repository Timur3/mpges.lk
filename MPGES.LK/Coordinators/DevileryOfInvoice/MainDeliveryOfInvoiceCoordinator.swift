//
//  MainDevileryCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

protocol DeliveryOfInvoiceTVControllerDelegate: class {
    func start()
    func startWithData(model: DeliveryOfInvoiceModelRoot)
    func didFinishPage()
}

class MainDeliveryOfInvoiceCoordinator: Coordinator {
    weak var parentCoordinator: ContractDetailsInfoCoordinator?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
extension MainDeliveryOfInvoiceCoordinator: DeliveryOfInvoiceTVControllerDelegate {
    func didFinishPage() {
        // todo отправить на сервер выбранный способ доставки
        parentCoordinator?.childDidFinish(self)
    }    
    
    func startWithData(model: DeliveryOfInvoiceModelRoot) {
        let devileryOfInvoiceTV: DeliveryOfInvoiceTVController = DeliveryOfInvoiceTVController(nibName: "DeliveryOfInvoiceTVController", bundle: nil)
        devileryOfInvoiceTV.delegate = self
        devileryOfInvoiceTV.deliveryOfTypeList = model.data
        self.navigationController.pushViewController(devileryOfInvoiceTV, animated: true)
    }
    
    func start() {
        //let devileryOfInvoiceTV: DeliveryOfInvoiceTVController = DeliveryOfInvoiceTVController(nibName: "DeliveryOfInvoiceTVController", bundle: nil)
        //devileryOfInvoiceTV.delegate = self
        //self.navigationController.pushViewController(devileryOfInvoiceTV, animated: true)
        ApiServiceAdapter.shared.getDeliveryOfInvoices(delegate: self)
    }
}
