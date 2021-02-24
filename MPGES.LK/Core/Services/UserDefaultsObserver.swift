//
//  UserDefaultsObserver.swift
//  mpges.lk
//
//  Created by Timur on 21.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsObserver: NSObject {
    let key: String
    private var onChange: (Any, Any) -> Void

    // 1
    init(key: String, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key = key
        super.init()
        UserDefaults.standard.addObserver(self, forKeyPath: key, options: [.old, .new], context: nil)
    }
    
    // 2
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }
    
    // 3
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: key, context: nil)
    }
}
