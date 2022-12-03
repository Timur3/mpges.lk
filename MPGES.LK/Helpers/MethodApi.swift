//
//  MethodApi.swift
//  mpges.lk
//
//  Created by Timur on 26.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
final class MethodApi {
    
    static let baseUrl = "https://api.mp-ges.ru/v2/"
    static let versionApi = "2"

    static let authApi = "auth/"
    static let refreshToken = "auth/refreshtoken/"
    static let getContractorById = "contractor/"
    static let getCalculationsByInvoiceId = "calculation/getbyinvoiceid/"
    static let getDevicesByContractId = "device/getbyContractid/"
    static let getDeliveryOfInvoice = "deliveryOfInvoice/getall/"
    static let getDeepLinkforIos = "sberbank/getdeeplink/ios/"
    static let getOfficesMark = "map/"
    // USER
    static let createUser = "user/signUp/"
    static let updateUser = "user/update/"
    static let getUser = "user/getProfile"
    static let checkEmail = "user/checkbyemail/"
    static let passwordRecovery = "user/passwordrecovery/"
    static let passwordChange = "user/passwordchange/"
    static let passwordReset = "user/passwordReset/"
    static let sendCodeForDeleteUser = "user/SendAccountDeleteCode/"
    static let deleteUser = "user/delete/"
    // RECEIVEDDATA
    static let getReceivedData = "receivedData/getbydeviceid/"
    static let getTemplateAddNew = "receivedData/getTemplateAddNew/"
    static let getReceivedDateVolumesForChart = "receivedData/volumesForChartByDeviceId/"
    static let receivedDataAddNew = "receivedData/addNew/"
    static let receivedDataDelete = "receivedData/delete/"
    // PAYMENT
    static let getStateOfPayment = "payment/getState/"
    static let getPaymentById = "payment/"
    static let getPaymentsByInvoiceId = "payment/getbyinvoiceid/"
    static let getPaymentsByContractId = "payment/getbyContractid/"
    static let initApplePay = "payment/initPay/ios"
    static let getReceiptUrl = "payment/getReceiptUrl/"
    // INVOICE
    static let getInvoicesByContractId = "invoice/getbyContractid/"
    static let sendInoicesByUserId = "invoice/sendInvoice/"
    static let sendInoicesByEmail = "invoice/sendInvoice/"
    static let getInvoicePdf = "invoice/getPdf/"
    // CONTRACT
    static let getContracts = "contract/getByUser/"
    static let getListOfContractNumbers = "contract/getListOfContractNumbers/"
    static let getContract = "contract/"
    static let getContractSaldoById = "contract/getSaldobyid/"
    static let getContractStatusById = "contract/getStatusbyid/"
    static let contractBinding = "contract/binding/"
    static let removeContractBinding = "contract/removeBinding/"
    static let checkContractByNumber = "contract/checkByNumber/"
    static let updateDeliveryMethod = "contract/updateDeliveryMethod"
}
