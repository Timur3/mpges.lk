//
//  ApiServiceAdapter.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ApiServiceAdapter {
    var methodApi = MethodApi()
    var uds = UserDataService()
    
    static let shared = ApiServiceAdapter()
    init(){ }
    
    func authApi(model: AuthModel, delegate: SingInViewControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.authApi, completion: delegate.resultAuthApi(modelResult:))
    }
    
    // получение списка договора пользователя
    func getContracts(delegate: ContractsListTVControllerUserDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getContracts, completion: delegate.setContracts(contracts:))
    }
    
    // проверка договора
    func checkByNumberContract(model: ContractNumberModel,delegate: ContractAddViewControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.checkContractByNumber, completion: delegate.resultCheckContract(result:))
    }
    
    // привязка договора
    func contractBinding(model: ContractBindingModel,delegate: ContractAddViewControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.contractBinding, completion: delegate.resultToBinding(result:))
    }
    
    // удаление привязки договора
    func removeContractBinding(model: ContractNumberModel, delegate: ContractsListTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.removeContractBinding, completion: delegate.resultRemoveContractBinding(result:))
    }
    
    // получение платежей по договору
    func getPaymentsByContractId(delegate: PaymentsTVControllerUserDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getPaymentsByContractId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по договору
    func getInvoiceByContractId(delegate: InvoicesTVControllerDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getInvoicesByContractId, completion: delegate.setInvoices(invoices:))
    }
    
    // получение приборов учета по договору
    func getDevicesByContractId(delegate: DevicesTVControllerUserDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getDevicesByContractId, completion: delegate.setDevices(devices:))
    }
    
    // получение приборов учета по договору
    func getContractById(delegate: ContractDetailsInfoTVControllerUserDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
    // получение профиля
    func getProfileById(delegate: ProfileTVControllerUserDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getUser, completion: delegate.setProfile(profile:))
    }
    
    // проверка email
    func checkByEmail(model: UserEmailModel, delegate: RecoveryPasswordViewControllerUserDelegate){
        ApiService.shared.requestByModel(model: model, requestMethod: .post, method: methodApi.checkEmail, completion: delegate.resultOfCheckEmail(result:))
    }
        
    // регистрация профиля
    func createUser(model: UserModel, delegate: SingUpViewControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.createUser, completion: delegate.resultOfCreateUser(result:))
    }
    
    // update user
    func updateUser(model: UserModel, delegate: ProfileTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.updateUser, completion: delegate.resultOfSaveProfile(result:))
    }
    
    // восстановление пароля
    func passwordRecovery(model: UserEmailModel, delegate: RecoveryPasswordViewControllerUserDelegate){
        ApiService.shared.requestByModel(model: model, requestMethod: .post, method: methodApi.passwordRecovery, completion: delegate.resultOfPassordRecovery(result:))
    }
    
    func loadSaldoContract(id: Int, label: UILabel) {
        ApiService.shared.loadTextInLabel(method: methodApi.getContractSaldoById, id: id, label: label)
    }
}
