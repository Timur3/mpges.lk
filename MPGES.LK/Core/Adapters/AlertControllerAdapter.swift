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
    
    func actionSheetConfirmShow(title: String, mesg: String, form: UIViewController, handler: @escaping (UIAlertAction) -> Void) {
        let alertConfirm = UIAlertController(title: title, message: mesg, preferredStyle: .actionSheet)
        let actionYes = UIAlertAction(title: "Да", style: .default, handler: handler)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertConfirm.addAction(actionYes)
        alertConfirm.addAction(actionCancel)
        form.present(alertConfirm, animated: true, completion: nil)
    }
}
