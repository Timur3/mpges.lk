//
//  UIButton+Extension.swift
//  mpges.lk
//
//  Created by Timur on 10.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func Shadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func Circle(){
        self.tintColor = .white
        self.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.backgroundColor = UIColor(red: 0.0, green: 0.4392, blue: 0.7294, alpha: 1.0)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
}
