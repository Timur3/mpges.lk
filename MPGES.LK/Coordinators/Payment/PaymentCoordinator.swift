//
//  PaymentCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 14.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit
import SafariServices

class PaymentCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public var contract: ContractModel?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let paymentTV: PaymentsTVController = PaymentsTVController()
        paymentTV.delegate = self
        paymentTV.contractId = contract!.id
        self.navigationController.pushViewController(paymentTV, animated: true)
    }
    
    
}
extension PaymentCoordinator: PaymentsTVControllerDelegate {
    func navigationPaymentInfoPage(uuid: String) {
        let webView: WebViewController = WebViewController()
        webView.uuid = uuid
        let navWebView: UINavigationController = UINavigationController(rootViewController: webView)
        self.navigationController.present(navWebView, animated: true, completion: nil)
    }
    
    func navigateToFirstPage() {
        //delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
    
    func navigationPaymentInfoForSafariService(uuid: String) {
        if let url = URL(string: MethodApi.baseUrlInitPro + uuid) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            self.navigationController.present(vc, animated: true, completion: nil)
        }
    }    
}
