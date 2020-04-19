//
//  DeviceCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 15.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//
import UIKit

class DeviceCoordinatorMain: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    public var contract: ContractModel?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let deviceTV: DevicesTVController = DevicesTVController()
        deviceTV.delegate = self
        deviceTV.contractId = contract!.id
        self.navigationController.pushViewController(deviceTV, animated: true)
    }
    
}
extension DeviceCoordinatorMain: DevicesTVControllerDelegate {
    
    func navigationReceivedDataPage(model: DeviceModel) {
        let receivedDataCoordinator = ReceivedDataCoordinator(navigationController: navigationController)
        receivedDataCoordinator.parentCoordinator = self
        receivedDataCoordinator.device = model
        childCoordinators.append(receivedDataCoordinator)
        receivedDataCoordinator.start()
    }
    
}
