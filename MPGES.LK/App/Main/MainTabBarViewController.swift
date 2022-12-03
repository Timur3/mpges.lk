//
//  MainTabBarViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol MainTabBarViewControllerDelegate: AnyObject {
    func navigateToContractsPage()
    func navigateToOfficesPage()
    func navigateToProfilePage()
}

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    public var email: String = ""
    public weak var delegateUser: MainTabBarViewControllerDelegate?
    
    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()
        self.tabBar.backgroundColor = .systemBackground.withAlphaComponent(0.6)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.tabBarItem.tag)")
        if (viewController.tabBarItem.tag == 1)
        {
            let v = viewController as! MapViewController
            //v.startPosition()
        }
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }
}
