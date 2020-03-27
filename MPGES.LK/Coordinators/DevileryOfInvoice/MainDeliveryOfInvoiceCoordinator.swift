//
//  MainDevileryCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class MainDeliveryOfInvoiceCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let devileryOfInvoiceTV: DeliveryOfInvoiceTVController = DeliveryOfInvoiceTVController(nibName: "DevileryOfInvoiceTVController", bundle: nil)
        //devileryOfInvoiceTV.delegate = self
        self.navigationController.pushViewController(devileryOfInvoiceTV, animated: true)
    }
    
}
extension MainDeliveryOfInvoiceCoordinator: DevicesTVControllerDelegate {
    func navigationReceivedDataPage() {
        let receivedDataCoordinator = ReceivedDataCoordinator(navigationController: navigationController)
        childCoordinators.append(receivedDataCoordinator)
        receivedDataCoordinator.start()
    }
}
