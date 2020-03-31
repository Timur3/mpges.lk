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
    func navigationReceivedDataPage(model: DeviceModel) {
        let receivedDataCoordinator = ReceivedDataCoordinator(navigationController: navigationController)
        receivedDataCoordinator.parentCoordinator = self
        receivedDataCoordinator.device = model
        childCoordinators.append(receivedDataCoordinator)
        receivedDataCoordinator.start()
    }
}
