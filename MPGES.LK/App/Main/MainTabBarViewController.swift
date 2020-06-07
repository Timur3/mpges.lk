//
//  MainTabBarViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol MainTabBarViewControllerDelegate: class {
    func navigateToContractsPage()
    func navigateToOfficesPage()
    func navigateToProfilePage()
}

class MainTabBarViewController: UITabBarController {
    public var email: String = ""
    public weak var delegateUser: MainTabBarViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.tabBarItem.tag)")
    }
}
