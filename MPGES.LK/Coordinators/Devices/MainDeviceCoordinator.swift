//
//  DeviceCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 15.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class MainDeviceCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let deviceTV: DevicesTVController = DevicesTVController(nibName: "DevicesTVController", bundle: nil)
        deviceTV.delegate = self
        self.navigationController.pushViewController(deviceTV, animated: true)
    }
}
extension MainDeviceCoordinator: DevicesTVControllerDelegate {
    func navigationReceivedDataPage() {
        let receivedDataCoordinator = ReceivedDataCoordinator(navigationController: navigationController)
        childCoordinators.append(receivedDataCoordinator)
        receivedDataCoordinator.start()
    }
}
