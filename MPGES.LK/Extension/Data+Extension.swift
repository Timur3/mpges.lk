//
//  Data+Extension.swift
//  mpges.lk
//
//  Created by Timur on 10.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
