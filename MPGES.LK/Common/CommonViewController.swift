//
//  CommonViewController.swift
//  mpges.lk
//
//  Created by Timur on 08.10.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    fileprivate var indicatorView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingIndicator() {
        /*indicatorView = UIView(frame: CGRect(x: (self.view.bounds.width / 2) - 25,
                                             y: (self.view.bounds.height / 2) - 25,
                                             width: 50,
                                             height: 50))*/
        
        indicatorView = UIView(frame: self.view.bounds)
                               
        indicatorView?.backgroundColor = UIColor.init(_colorLiteralRed: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = indicatorView!.center
        indicator.startAnimating()
        indicatorView?.addSubview(indicator)
        self.navigationController?.view.addSubview(indicatorView!)
    }
    
    func hideLoadingIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}
