//
//  DevicesTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 30.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol DevicesTVControllerDelegate {
    var sections: [String] { get }
    func setDevices(devices:DevicesModelRoot)
}
