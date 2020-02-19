//
//  Coordinator.swift
//  mpges.lk
//
//  Created by Timur on 16.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }

    // All coordinators will be initilised with a navigation controller
    init(navigationController:UINavigationController)

    func start()
}
