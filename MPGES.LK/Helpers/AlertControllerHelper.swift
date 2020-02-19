//
//  AlertControllerService.swift
//  mpges.lk
//
//  Created by Timur on 09.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class AlertControllerHelper {
    public static let shared = AlertControllerHelper()   
    
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
}
