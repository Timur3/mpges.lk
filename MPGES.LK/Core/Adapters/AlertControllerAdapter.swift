//
//  AlertControllerService.swift
//  mpges.lk
//
//  Created by Timur on 09.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class AlertControllerAdapter {
    public static let shared = AlertControllerAdapter()   
    
    func show(title: String, mesg: String, form: UIViewController){
        let alert = UIAlertController(title: title, message: mesg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        
        alert.addAction(action)
        
        form.present(alert, animated: true, completion: nil)
    }
    
    func show(title: String, mesg: String, form: UIViewController, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: mesg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: handler)
        
        alert.addAction(action)
        
        form.present(alert, animated: true, completion: nil)
    }
    
    func actionSheetConfirmShow(title: String, mesg: String, form: UIViewController, handlerYes: @escaping (UIAlertAction) -> Void, handlerCancel: ((UIAlertAction) -> Void)? = nil) {
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        let alertConfirm = UIAlertController(title: title, message: mesg, preferredStyle: alertStyle)
        let actionYes = UIAlertAction(title: "Да", style: .default, handler: handlerYes)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: handlerCancel)
        alertConfirm.addAction(actionYes)
        alertConfirm.addAction(actionCancel)
        form.present(alertConfirm, animated: true, completion: nil)
    }
    
}
