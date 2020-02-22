//
//  File.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import RealmSwift

protocol PaymentsTVControllerDelegate {
    var sections: [String] { get }
    func setPayments(payments:PaymentsModelRoot)
    func refreshData()
    func getDataForRealm()
}
