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
    let getContractSaldoById: String
    let contractBinding: String
    let removeContractBinding: String
    let checkContractByNumber: String
    let getPaymentById: String
    let getPaymentsByContractId: String
    let getDevicesByContractId: String
    let getReceivedData: String
    let getInvoicesByContractId: String
    let createUser: String
    let updateUser: String
    let getUser: String
    let checkEmail: String
    let passwordRecovery: String
       
    init() {
        authApi = "auth/"
        getContracts = "contract/getByUser/"
        getContract = "contract/"
        getContractSaldoById = "contract/getsaldobyid/"
        contractBinding = "contract/binding/"
        removeContractBinding = "contract/removeBinding/"
        checkContractByNumber = "contract/checkByNumber/"
        getPaymentById = "payment/"
        getPaymentsByContractId = "payment/getbypackid/"
        getInvoicesByContractId = "invoice/getbycontractid/"
        getDevicesByContractId = "device/getbypackid/"
        getReceivedData = "receivedData/getbydeviceid/"
        createUser = "user/create/"
        updateUser = "user/update/"
        getUser = "user/"
        checkEmail = "user/checkbyemail/"
        passwordRecovery = "user/passwordrecovery/"
    }
}
