//
//  BarButtonItemHelper.swift
//  mpges.lk
//
//  Created by Timur on 16.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomUIBarButtonItem(target: AnyObject, selector: Selector) -> UIBarButtonItem {
    
    let barBtn = UIBarButtonItem(image: UIImage(systemName: myImage.close.rawValue),
                                 style: .plain,
                                 target: target,
                                 action: selector)
    return barBtn
}

