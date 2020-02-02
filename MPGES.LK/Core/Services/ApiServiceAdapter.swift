//
//  ApiServiceAdapter.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation


class ApiServiceAdapter {
    var methodApi = MethodApi()
    var uds = UserDataService()
    
    static let shared = ApiServiceAdapter()
    init(){ }
    
    // получение списка договора пользователя
    func getContracts(delegate: ContractsTVControllerDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getContracts, completion: delegate.setContracts(contracts:))
    }
    
    // получение платежей по договору
    func getPaymentsByContractId(delegate: PaymentsTVControllerDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getPaymentsByContractId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по договору
    func getInvoiceByContractId(delegate: InvoicesTVControllerDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getInvoicesByContractId, completion: delegate.setInvoices(invoices:))
    }
    
    // получение приборов учета по договору
    func getDevicesByContractId(delegate: DevicesTVControllerDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getDevicesByContractId, completion: delegate.setDevices(devices:))
    }
    
    // получение приборов учета по договору
    func getContractById(delegate: ContractDetailsInfoTVControllerDelagate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
}
