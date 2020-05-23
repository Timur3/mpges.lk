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
    let getTemplateAddNew: String
    let ReceivedDataAddNew: String
    let getInvoicesByContractId: String
    let sendInoicesByEmail: String
    let getCalculationsByInvoiceId: String
    let createUser: String
    let updateUser: String
    let getUser: String
    let checkEmail: String
    let passwordRecovery: String
    let getDeliveryOfInvoice: String
    let updateDeliveryMethod: String
    init() {
        authApi = "auth/"
        getContracts = "contract/getByUser/"
        getListOfContractNumbers = "contract/getListOfContractNumbers/"
        getContract = "contract/"
        getContractSaldoById = "contract/getsaldobyid/"
        contractBinding = "contract/binding/"
        removeContractBinding = "contract/removeBinding/"
        checkContractByNumber = "contract/checkByNumber/"
        updateDeliveryMethod = "contract/updateDeliveryMethod"
        getPaymentById = "payment/"
        getPaymentsByInvoiceId = "payment/getbyinvoiceid/"
        getPaymentsByContractId = "payment/getbyContractid/"
        getInvoicesByContractId = "invoice/getbyContractid/"
        sendInoicesByEmail = "invoice/sendInvoice/"
        getCalculationsByInvoiceId = "calculation/getbyinvoiceid/"
        getDevicesByContractId = "device/getbyContractid/"
        getReceivedData = "receivedData/getbydeviceid/"
        getTemplateAddNew = "receivedData/getTemplateAddNew/"
        ReceivedDataAddNew = "receivedData/AddNew/"
        createUser = "user/create/"
        updateUser = "user/update/"
        getUser = "user/"
        checkEmail = "user/checkbyemail/"
        passwordRecovery = "user/passwordrecovery/"
        getDeliveryOfInvoice = "deliveryOfInvoice/getall/"
    }
}
