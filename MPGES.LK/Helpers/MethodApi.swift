//
//  MethodApi.swift
//  mpges.lk
//
//  Created by Timur on 26.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
class MethodApi {
    
    let authApi: String
    let getContracts: String
    let getContract: String
    let getListOfContractNumbers: String
    let getContractSaldoById: String
    let contractBinding: String
    let removeContractBinding: String
    let checkContractByNumber: String
    let getPaymentById: String
    let getPaymentsByInvoiceId: String
    let getPaymentsByContractId: String
    let getDevicesByContractId: String
    let getReceivedData: String
    let getInvoicesByContractId: String
    let getCalculationsByInvoiceId: String
    let createUser: String
    let updateUser: String
    let getUser: String
    let checkEmail: String
    let passwordRecovery: String
    let getDeliveryOfInvoice: String
       
    init() {
        authApi = "auth/"
        getContracts = "contract/getByUser/"
        getListOfContractNumbers = "contract/getListOfContractNumbers/"
        getContract = "contract/"
        getContractSaldoById = "contract/getsaldobyid/"
        contractBinding = "contract/binding/"
        removeContractBinding = "contract/removeBinding/"
        checkContractByNumber = "contract/checkByNumber/"
        getPaymentById = "payment/"
        getPaymentsByInvoiceId = "payment/getbyinvoiceid/"
        getPaymentsByContractId = "payment/getbypackid/"
        getInvoicesByContractId = "invoice/getbycontractid/"
        getCalculationsByInvoiceId = "calculation/getbyinvoiceid/"
        getDevicesByContractId = "device/getbypackid/"
        getReceivedData = "receivedData/getbydeviceid/"
        createUser = "user/create/"
        updateUser = "user/update/"
        getUser = "user/"
        checkEmail = "user/checkbyemail/"
        passwordRecovery = "user/passwordrecovery/"
        getDeliveryOfInvoice = "deliveryOfInvoice/getall/"
    }
}
