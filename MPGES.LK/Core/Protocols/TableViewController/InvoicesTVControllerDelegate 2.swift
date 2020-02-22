//
//  InvoiceTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 30.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
protocol InvoicesTVControllerDelegate {
    var sections: [String] { get }
    func setInvoices(invoices:InvoiceModelRoot)
    
}
