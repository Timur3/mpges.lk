//
//  ActivityIndicatorViewForButton.swift
//  mpges.lk
//
//  Created by Timur on 15.10.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorViewForNaviagtionItem {
    public static let shared = ActivityIndicatorViewForNaviagtionItem()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    func showAI(nav: UINavigationItem) {
        DispatchQueue.main.async {
            let uiBusy = UIActivityIndicatorView(style: .medium)
            uiBusy.hidesWhenStopped = true
            uiBusy.startAnimating()
            nav.rightBarButtonItem = UIBarButtonItem(customView: uiBusy)
        }
    }
    
    func hiddenAI(nav: UINavigationItem) {
        DispatchQueue.main.async {

        }
    }
}
