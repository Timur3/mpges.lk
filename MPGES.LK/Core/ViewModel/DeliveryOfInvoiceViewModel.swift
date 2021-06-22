//
//  DeliveryOfInvoiceViewModel.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation

class DeliveryOfInvoiceViewModel: TableViewViewModelType {
    
    var deliveryOfInvoices = [
            InvoiceDeliveryMethodModel(id: 1, devileryMethodName: "Почта", description: "", selected: false),
            InvoiceDeliveryMethodModel(id: 2, devileryMethodName: "Почта2", description: "", selected: false),
            InvoiceDeliveryMethodModel(id: 3, devileryMethodName: "Почта3", description: "", selected: true),
            InvoiceDeliveryMethodModel(id: 4, devileryMethodName: "Почта4", description: "", selected: false),
            InvoiceDeliveryMethodModel(id: 5, devileryMethodName: "Почта5", description: "", selected: false),
            InvoiceDeliveryMethodModel(id: 6, devileryMethodName: "Почта6", description: "", selected: false)
        ]
    
    private var api: ApiService!
    
    func numberOfRows() -> Int {
        return deliveryOfInvoices.count
    }
    
    init() {
        self.api = ApiService()
        getData()
        debugPrint("init")
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType {
        let model = deliveryOfInvoices[indexPath.row]
        return TableViewCellViewModel(deliveryOfInvoice: model)
    }
    
    func getData() {
        self.api.requestByToken(method: MethodApi.getDeliveryOfInvoice) { (responseData: ResultModel<[InvoiceDeliveryMethodModel]>) in
            debugPrint("get")
            guard let data = responseData.data else { return }
            self.deliveryOfInvoices = data
        }
    }
}
