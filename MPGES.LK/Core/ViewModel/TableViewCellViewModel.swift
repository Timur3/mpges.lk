//
//  TableViewCellViewModel.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var deliveryOfInvoice: InvoiceDeliveryMethodModel
    
    var textLabel: String {
        return deliveryOfInvoice.devileryMethodName 
    }
    
    var detailTextLabel: String {
        return deliveryOfInvoice.description ?? ""
    }
    
    var image: UIImage {
        return UIImage(systemName: myImage.mail.rawValue)!
    }
    
    var selected: Bool {
        return deliveryOfInvoice.selected
    }
    
    init(deliveryOfInvoice: InvoiceDeliveryMethodModel) {
        self.deliveryOfInvoice = deliveryOfInvoice
    }
}
