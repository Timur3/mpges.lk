//
//  ActivityIndicatorViewService.swift
//  mpges.lk
//
//  Created by Timur on 04.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ActivityIndicatorViewService {
    public static let shared = ActivityIndicatorViewService()
    
    var containerView = UIView()
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    func showView(form: UIView) {
        
        let window = UIWindow(frame: form.bounds)
        
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
        UIApplication.shared.windows[0].addSubview(containerView)
        
        activityIndicator.startAnimating()
        
    }
    
    func showViewWinthoutBackground(form: UIView) { 
        let window = UIWindow(frame: form.bounds)
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = window.center
        
        containerView.addSubview(activityIndicator)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    func hideView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
            self.containerView = UIView()
        }
    }
}
