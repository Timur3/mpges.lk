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
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let paymentTV: PaymentsTVController = PaymentsTVController(nibName: "PaymentsTVController", bundle: nil)
        paymentTV.delegate = self
        self.navigationController.pushViewController(paymentTV, animated: true)
    }
    

}
extension PaymentCoordinator: PaymentsTVControllerDelegate {
    func navigationPaymentInfoPage(payment: PaymentModel) {
        
    }
    
    func navigateToFirstPage() {
        //delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}
