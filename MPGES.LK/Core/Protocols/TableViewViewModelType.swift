//
//  TableViewModelType.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation

protocol TableViewViewModelType {
    
    func numberOfRows() -> Int
    var deliveryOfInvoices: [InvoiceDeliveryMethodModel] { get }
    //func getData<T: Decodable>() -> ResultModel<[T]>
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType
}
