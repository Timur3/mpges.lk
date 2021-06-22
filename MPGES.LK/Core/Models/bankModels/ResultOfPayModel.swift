//
//  ResultOfPayModel.swift
//  mpges.lk
//
//  Created by Timur on 11.10.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct ResultOfPayModel {
    let state: String
    let summa: Decimal
}

public struct RequestOfPayModel {
    var id: Int
    var summa: Decimal
}
