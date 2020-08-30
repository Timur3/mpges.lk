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
    let getContractorById: String
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
    let receivedDataAddNew: String
    let receivedDataDelete: String
    let getInvoicesByContractId: String
    let sendInoicesByUserId: String
    let sendInoicesByEmail: String
    let getCalculationsByInvoiceId: String
    let createUser: String
    let updateUser: String
    let getUser: String
    let checkEmail: String
    let passwordRecovery: String
    let getDeliveryOfInvoice: String
    let updateDeliveryMethod: String
    let getDeepLinkforIos: String
    let initApplePay: String
    init() {
        authApi = "auth/"
        getContracts = "contract/getByUser/"
        getListOfContractNumbers = "contract/getListOfContractNumbers/"
        getContract = "contract/"
        getContractorById = "contractor/"
        getContractSaldoById = "contract/getsaldobyid/"
        contractBinding = "contract/binding/"
        removeContractBinding = "contract/removeBinding/"
        checkContractByNumber = "contract/checkByNumber/"
        updateDeliveryMethod = "contract/updateDeliveryMethod"
        getPaymentById = "payment/"
        getPaymentsByInvoiceId = "payment/getbyinvoiceid/"
        getPaymentsByContractId = "payment/getbyContractid/"
        initApplePay = "payment/initApplePay"
        getInvoicesByContractId = "invoice/getbyContractid/"
        sendInoicesByUserId = "invoice/sendInvoice/"
        sendInoicesByEmail = "invoice/sendInvoice/"
        getCalculationsByInvoiceId = "calculation/getbyinvoiceid/"
        getDevicesByContractId = "device/getbyContractid/"
        getReceivedData = "receivedData/getbydeviceid/"
        getTemplateAddNew = "receivedData/getTemplateAddNew/"
        receivedDataAddNew = "receivedData/addNew/"
        receivedDataDelete = "receivedData/delete/"
        createUser = "user/create/"
        updateUser = "user/update/"
        getUser = "user/"
        checkEmail = "user/checkbyemail/"
        passwordRecovery = "user/passwordrecovery/"
        getDeliveryOfInvoice = "deliveryOfInvoice/getall/"
        getDeepLinkforIos = "sberbank/getdeeplinkforios/"
    }
}
