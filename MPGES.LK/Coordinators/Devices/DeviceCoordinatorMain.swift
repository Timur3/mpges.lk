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
        let receivedDataTVController: ReceivedDataTVController = ReceivedDataTVController()
        // todo доделать получение данных из realm
        receivedDataTVController.delegate = self
        receivedDataTVController.device = model
        self.navigationController.pushViewController(receivedDataTVController, animated: true)
    }
    
    func showReceivedDataAddNewTemplatesOneStepPage(device: DeviceModel){
        let receivedDataAddNewTemplateTVController : ReceivedDataAddNewTemplateTVControllerOneStep = ReceivedDataAddNewTemplateTVControllerOneStep()
        receivedDataAddNewTemplateTVController.delegate = self
        receivedDataAddNewTemplateTVController.device = device
        let navReceivedDataAddNewTemplateTVController: UINavigationController = UINavigationController(rootViewController: receivedDataAddNewTemplateTVController)
        self.navigationController.present(navReceivedDataAddNewTemplateTVController, animated: true, completion: nil)
    }
    
    func showReceivedDataAddNewTemplatesTwoStepPage(device: DeviceModel, nav: UINavigationController){
        let receivedDataAddNewTemplateTVController : ReceivedDataAddNewTemplateTVControllerTwoStep = ReceivedDataAddNewTemplateTVControllerTwoStep()
        receivedDataAddNewTemplateTVController.delegate = self
        receivedDataAddNewTemplateTVController.device = device
        nav.pushViewController(receivedDataAddNewTemplateTVController, animated: true)
    }
    
}
