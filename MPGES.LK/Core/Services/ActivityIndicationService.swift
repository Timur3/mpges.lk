//
//  ActivityIndicationService.swift
//  mpges.lk
//
//  Created by Timur on 25.01.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicationService {
    public static let shared = ActivityIndicationService()
    
    var containerView = UIView()
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    func showView(form: UIView, heightTab: CGFloat = 0, heightNav: CGFloat = 0) {
        let window = UIWindow(frame: form.bounds)
        //containerView.frame = window.frame
        containerView.frame = CGRect(x: 0, y: heightNav*2, width: window.frame.width, height: window.frame.height - heightTab*2)
        containerView.center = window.center
        containerView.backgroundColor = .systemBackground //UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = window.center
        loadingView.backgroundColor = .white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.layer.borderColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2)
        
        loadingView.addSubview(activityIndicator)
        containerView.addSubview(loadingView)
        UIApplication.shared.windows[0].addSubview(containerView)
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
