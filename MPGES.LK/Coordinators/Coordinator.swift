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

    // Все координаторы будут инициализированы с помощью навигационного контроллера
    init(navigationController: UINavigationController)

    func start()
}
