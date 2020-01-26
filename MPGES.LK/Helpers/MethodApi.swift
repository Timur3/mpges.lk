//
//  MethodApi.swift
//  mpges.lk
//
//  Created by Timur on 26.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
class MethodApi {
    
    let getContracts: String
    let getPaymentById: String
    let getPaymentsByContractId: String
    let getDevicesByContractId: String
    let getReceivedData: String
       
    init() {
        getContracts = "contract/getByUserid/"
        getPaymentById = "payment"
        getPaymentsByContractId = "payment/getbypackid/"
        getDevicesByContractId = "device/getbypackid/"
        getReceivedData = "receivedData/getbydeviceid/"
    }
}
