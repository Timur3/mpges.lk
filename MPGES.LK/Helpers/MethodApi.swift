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
    static let baseUrlInitPro = "http://kassa.initpro.ru/lk/check-bill/"
    
    static let authApi = "auth/"
    static let getContracts = "contract/getByUser/"
    static let getListOfContractNumbers = "contract/getListOfContractNumbers/"
    static let getContract = "contract/"
    static let getContractorById = "contractor/"
    static let getContractSaldoById = "contract/getSaldobyid/"
    static let getContractStatusById = "contract/getStatusbyid/"
    static let contractBinding = "contract/binding/"
    static let removeContractBinding = "contract/removeBinding/"
    static let checkContractByNumber = "contract/checkByNumber/"
    static let updateDeliveryMethod = "contract/updateDeliveryMethod"
    static let getPaymentById = "payment/"
    static let getPaymentsByInvoiceId = "payment/getbyinvoiceid/"
    static let getPaymentsByContractId = "payment/getbyContractid/"
    static let initApplePay = "payment/initApplePay"
    static let getInvoicesByContractId = "invoice/getbyContractid/"
    static let sendInoicesByUserId = "invoice/sendInvoice/"
    static let sendInoicesByEmail = "invoice/sendInvoice/"
    static let getCalculationsByInvoiceId = "calculation/getbyinvoiceid/"
    static let getDevicesByContractId = "device/getbyContractid/"
    static let getReceivedData = "receivedData/getbydeviceid/"
    static let getTemplateAddNew = "receivedData/getTemplateAddNew/"
    static let getReceivedDateVolumesForChart = "receivedData/volumesForChartByDeviceId/"
    static let receivedDataAddNew = "receivedData/addNew/"
    static let receivedDataDelete = "receivedData/delete/"
    static let createUser = "user/signUp/"
    static let updateUser = "user/update/"
    static let getUser = "user/"
    static let checkEmail = "user/checkbyemail/"
    static let passwordRecovery = "user/passwordrecovery/"
    static let passwordChange = "user/passwordchange/"
    static let passwordReset = "user/passwordReset"
    static let getDeliveryOfInvoice = "deliveryOfInvoice/getall/"
    static let getDeepLinkforIos = "sberbank/getdeeplinkforios/"
    static let getStateOfPayment = "payment/getState/"
}
