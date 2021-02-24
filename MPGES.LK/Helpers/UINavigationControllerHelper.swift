//
//  UINavigationControllerHelper.swift
//  mpges.lk
//
//  Created by Timur on 20.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    private var containerView: UIView {
        set { }
        get { return UIView() }
    }
    private var loadingView: UIView {
        get { return UIView() }
    }
    private var activityIndicator: UIActivityIndicatorView {
        get { return UIActivityIndicatorView(style: .large) }
    }

    
    func showActivityIndicator1() {

        let window = UIWindow(frame: self.view.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = .none //UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = window.center
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2)
        
        loadingView.addSubview(activityIndicator)
        containerView.addSubview(loadingView)
        self.view.addSubview(containerView)
        
        activityIndicator.startAnimating()
        
    }
    
    func hideActivityIndicator1() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
            self.containerView = UIView()
        }
    }
}
