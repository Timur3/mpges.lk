//
//  ActivityIndicatorViewService2.swift
//  mpges.lk
//
//  Created by Timur on 04.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ActivityIndicatorViewService2 {
    public static let shared = ActivityIndicatorViewService2()
    
    private var containerView: UIView?
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    func showView(){
        let window = UIWindow(frame: UIScreen.main.bounds)
        UIApplication.shared.keyWindow?.addSubview(getLoader(window: window))
        activityIndicator.startAnimating()
    }
    
    private func getLoader(window: UIWindow) -> UIView {
        if (containerView == nil) {
            containerView = UIView()
            containerView!.frame = window.frame
            containerView!.center = window.center
            containerView!.backgroundColor = .none
            
            let loadingView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = window.center
            loadingView.backgroundColor = .white
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            loadingView.layer.borderColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.center = CGPoint(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2)
            
            loadingView.addSubview(activityIndicator)
            containerView!.addSubview(loadingView)
        }
        return containerView!
    }
    
    func hideView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView?.removeFromSuperview()
        }
    }
}
