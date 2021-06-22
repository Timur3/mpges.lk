//
//  BarButtonItemHelper.swift
//  mpges.lk
//
//  Created by Timur on 16.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomUIBarButtonItem(image: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
    
    let barBtn = UIBarButtonItem(image: UIImage(systemName: image),
                                 style: .plain,
                                 target: target,
                                 action: action)
    return barBtn
}

func getCloseUIBarButtonItem(target: AnyObject, action: Selector) -> UIBarButtonItem {
    
    let barBtn = UIBarButtonItem(image: UIImage(systemName: myImage.close.rawValue),
                                 style: .plain,
                                 target: target,
                                 action: action)
    return barBtn
}

func getPlusUIBarButtonItem(target: AnyObject, action: Selector) -> UIBarButtonItem {
    
    let barBtn = UIBarButtonItem(image: UIImage(systemName: myImage.plus.rawValue),
                                 style: .plain,
                                 target: target,
                                 action: action)
    return barBtn
}

