//
//  ApiServiceAdapter.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ApiServiceWrapper {
    var methodApi = MethodApi()
    var uds = UserDataService()
    
    static let shared = ApiServiceWrapper()
    init(){ }
    
    func authApi(model: AuthModel, delegate: SingInTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.authApi, completion: delegate.resultAuthApi(result:))
    }
    
    //
    func getDeepLinkForIos(number: Int, delegate: PayWithSberbankOnlineTVControllerDelegate) {
        ApiService.shared.requestById(id: number, method: methodApi.getDeepLinkforIos, completion: delegate.navigationToSberApp(response:))
    }
    
    // получение списка договора пользователя
    func getContracts(delegate: ContractsTVControllerUserDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getContracts, completion: delegate.setContracts(contracts:))
    }
    
    // проверка договора
    func checkByNumberContract(model: ContractNumberModel,delegate: ContractAddTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.checkContractByNumber, completion: delegate.resultCheckContract(result:))
    }
    
    // привязка договора
    func contractBinding(model: ContractBindingModel,delegate: ContractAddTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.contractBinding, completion: delegate.resultToBinding(result:))
    }

    // удаление привязки договора
    func removeContractBinding(model: ContractNumberModel, delegate: ContractsTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.removeContractBinding, completion: delegate.resultRemoveContractBinding(result:))
    }
    func updateDeliveryMethod(model: UpdateDeliveryMethodModel, delegate: DeliveryMethodTVControllerDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.updateDeliveryMethod, completion: delegate.resultOfUpdateDeliveryMethod(for:))
    }
    // получение начисление по квитанции
    func getCalculationsByInvoiceId(id: Int, delegate: InvoiceDetailsInfoTableViewControllerDelegate){
        ApiService.shared.requestById(id: id, method: methodApi.getCalculationsByInvoiceId, completion: delegate.setCalculations(calculations:))
    }
    // получение платежей по договору
    func getPaymentsByContractId(id: Int, delegate: PaymentsTVControllerUserDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getPaymentsByContractId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по квитанции
    func getPaymentsByInvoiceId(id: Int, delegate: InvoiceDetailsInfoTableViewControllerDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getPaymentsByInvoiceId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по договору
    func getInvoicesByContractId(id: Int, delegate: InvoicesTableViewControllerUserDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getInvoicesByContractId, completion: delegate.setInvoices(invoices:))
    }
    
    // отправка платежного документа
    func sendInvoiceByEmail(id: Int, delegate: InvoicesTableViewControllerUserDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.sendInoicesByUserId, completion: delegate.responseSend(result:))
    }
    
    func sendInvoiceByEmail(model: SendInvoiceModel, delegate: InvoicesTableViewControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.sendInoicesByEmail, completion: delegate.responseSend(result:))
    }
    
    // получение приборов учета по договору
    func getDevicesByContractId(id: Int, delegate: DevicesTVControllerUserDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getDevicesByContractId, completion: delegate.setDevices(devices:))
    }
    
    // получение шаблона для передачи показаний
    func getReceivedDataAddNewTemplatesByDeviceId(id: Int, delegate: ReceivedDataAddNewTemplateTVControllerOneStepDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getTemplateAddNew, completion: delegate.setData(model:))
    }
    
    // получение показаний по прибору учета
    func getReceivedDataByDeviceId(id: Int, delegate: ReceivedDataTVControllerDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getReceivedData, completion: delegate.setData(model:))
    }
    
    //
    func sendReceivedData(model: [ReceivedDataOfSendingModel], delegate: ReceivedDataAddNewTemplateTVControllerDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.receivedDataAddNew, completion: delegate.resultOfSending(result:))
    }
    
    func receivedDataDelete(id: Int, delegate: ReceivedDataTVControllerDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.receivedDataDelete, completion: delegate.resultOfDelete(result:))
    }
    
    // получение деталей по договору
    func getContractById(id: Int, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        ApiService.shared.requestById(id: id, method: methodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
    func getContractById(delegate: ContractDetailsInfoTVControllerUserDelegate) {
        ApiService.shared.requestById(id: uds.getCurrentContract()!, method: methodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
    // получение профиля
    func getProfileById(delegate: ProfileTVControllerUserDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getUser, completion: delegate.setProfile(profile:))
    }
    
    // проверка email
    func checkByEmail(model: UserEmailModel, delegate: RecoveryPasswordTVControllerUserDelegate){
        ApiService.shared.requestByModel(model: model, requestMethod: .post, method: methodApi.checkEmail, completion: delegate.resultOfCheckEmail(result:))
    }
        
    // регистрация профиля
    func createUser(model: UserCreateModel, delegate: SingUpTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.createUser, completion: delegate.resultOfCreateUser(result:))
    }
    
    // update user
    func updateUser(model: UserModel, delegate: ProfileTVControllerUserDelegate) {
        ApiService.shared.requestByModel(model: model, method: methodApi.updateUser, completion: delegate.resultOfSaveProfile(result:))
    }
    
    // восстановление пароля
    func passwordRecovery(model: UserEmailModel, delegate: RecoveryPasswordTVControllerUserDelegate){
        ApiService.shared.requestByModel(model: model, requestMethod: .post, method: methodApi.passwordRecovery, completion: delegate.resultOfPassordRecovery(result:))
    }
    
    // получение способов доставки
    func getDeliveryOfInvoices(delegate: DeliveryMethodTVControllerDelegate) {
        ApiService.shared.requestByToken(method: methodApi.getDeliveryOfInvoice, completion: delegate.setData(for:))
    }
    
    func loadSaldoContract(id: Int, label: UILabel) {
        ApiService.shared.loadTextInLabel(method: methodApi.getContractSaldoById, id: id, label: label)
    }
    
    func loadSaldoContractForString(id: Int) -> String {
        return ApiService.shared.loadTextForString(method: methodApi.getContractSaldoById, id: id)
    }
}
