//
//  PaymentCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 14.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class PaymentCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public var contractId: Int = 0
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let paymentTV: PaymentsViewController = PaymentsViewController()
        paymentTV.contractId = contractId
        self.navigationController.pushViewController(paymentTV, animated: true)
    }
}
