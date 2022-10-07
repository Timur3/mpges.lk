//
//  MyTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 23.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class CommonTableViewController: UITableViewController {
    public var indexPath: IndexPath?
    fileprivate var indicatorView: UIView?
    
    func showLoadingIndicator() {
        indicatorView = UIView(frame: self.view.bounds)
        indicatorView?.backgroundColor = UIColor.init(_colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
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
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ActivityIndicationService.shared.hideView()
    }
    
    func hiddenAI(){
        guard let index = self.indexPath else { return }
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: index)!)
        ActivityIndicationService.shared.hideView()
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
