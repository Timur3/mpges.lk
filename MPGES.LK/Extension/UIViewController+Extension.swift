//
//  UIViewController+Extension.swift
//  mpges.lk
//
//  Created by Timur on 19.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showActivityIndication() {
        let alert = UIAlertController(title: nil, message: "Загрузка...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, mesg: String){
        let alert = UIAlertController(title: title, message: mesg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, mesg: String, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: mesg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: handler)
        
        alert.addAction(action)        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionSheetConfirm(title: String, message: String, handlerYes: @escaping (UIAlertAction) -> Void, handlerCancel: ((UIAlertAction) -> Void)? = nil) {
        var alertStyle = UIAlertController.Style.actionSheet
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        
        let alertConfirm = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let actionYes = UIAlertAction(title: "Да", style: .default, handler: handlerYes)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: handlerCancel)
        alertConfirm.addAction(actionYes)
        alertConfirm.addAction(actionCancel)
        
        self.present(alertConfirm, animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 13)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 40))
        toastLabel.backgroundColor = UIColor.systemGray.withAlphaComponent(1)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIApplication.shared.keyWindow?.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showT(message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
