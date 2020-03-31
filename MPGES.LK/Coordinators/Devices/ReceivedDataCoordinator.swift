//
//  ReceivedDataCoordinator.swift
//  mpges.lk
//
//  Created by Timur on 15.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataTVControllerDelegate: class {
    func startWithData(model: ReceivedDataModelRoot)
}

class ReceivedDataCoordinator: Coordinator {
    var parentCoordinator: MainDeviceCoordinator?
    var device: DeviceModel?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
extension ReceivedDataCoordinator: ReceivedDataTVControllerDelegate {
    func start() {
        //let receivedDataTV: ReceivedDataTVController = ReceivedDataTVController(nibName: "ReceivedDataTVController", bundle: nil)
        //receivedDataTV.delegate = self
        //self.navigationController.pushViewController(receivedDataTV, animated: true)
        ApiServiceAdapter.shared.getReceivedDataByDeviceId(id: device!.id, delegate: self)
    }
    
    func startWithData(model: ReceivedDataModelRoot) {
        let receivedDataTV: ReceivedDataTVController = ReceivedDataTVController(nibName: "ReceivedDataTVController", bundle: nil)
        // todo доделать получение данных из realm
        receivedDataTV.receivedDataList =  mapToReceivedDataModelView(receivedData: model.data)
        receivedDataTV.delegate = self
        self.navigationController.pushViewController(receivedDataTV, animated: true)
    }
    
    
    func mapToReceivedDataModelView(receivedData: [ReceivedDataModel]) -> [ReceivedDataModelVeiw] {
        var res = [ReceivedDataModelVeiw]()
        let models = receivedData.groupBy { $0.receivedDataYear() }
        for mod in models{
            let receivedDataVM = ReceivedDataModelVeiw(year: mod.key, receivedData: mod.value as [ReceivedDataModel])
            res.append(receivedDataVM)
        }
        return res.sorted(by: { $0.year > $1.year })
    }
}
