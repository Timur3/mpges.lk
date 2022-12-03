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
        indicatorView = IndicatorView()
        indicatorView?.center = self.view.center
        self.navigationController?.view.addSubview(indicatorView!)
    }
    
    func hideLoadingIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
