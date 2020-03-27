//
//  ReceivedDataCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 15.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let receivedDataTV: ReceivedDataTVController = ReceivedDataTVController(nibName: "ReceivedDataTVController", bundle: nil)
        receivedDataTV.delegate = self
        self.navigationController.pushViewController(receivedDataTV, animated: true)
    }
    

}
extension ReceivedDataCoordinator: ReceivedDataTVControllerDelegate {
}
