//
//  ApiServiceAdapter.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ApiServiceWrapper {
    let uds = UserDataService()
    let api = ApiService.shared
    
    //let api: ApiServiceProtocol?
    
    static let shared = ApiServiceWrapper()
    
    private init() {}
    //init(api: ApiServiceProtocol){
        //self.api = api
    //}
    
    func authApi(model: SignInModel, delegate: SignInTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.authApi, completion: delegate.resultAuthApi(result:))
    }
    
    //
    func getDeepLinkForIos(number: Int, delegate: PayWithSberbankOnlineTVControllerDelegate) {
        api.requestById(id: number, method: MethodApi.getDeepLinkforIos, completion: delegate.navigationToSberApp(response:))
    }
    
    // получение списка договора пользователя
    func getContracts(delegate: ContractsTVControllerUserDelegate) {
        api.requestByToken(method: MethodApi.getContracts, completion: delegate.setContracts(contracts:))
    }
    
    // проверка договора
    func checkByNumberContract(model: ContractNumberModel, delegate: ContractAddTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.checkContractByNumber, completion: delegate.resultCheckContract(result:))
    }
    
    // привязка договора
    func contractBinding(model: ContractBindingModel, delegate: ContractAddTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.contractBinding, completion: delegate.resultToBinding(result:))
    }
    
    // удаление привязки договора
    func removeContractBinding(model: ContractNumberModel, delegate: ContractsTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.removeContractBinding, completion: delegate.resultRemoveContractBinding(result:))
    }
    func updateDeliveryMethod(model: UpdateDeliveryMethodModel, delegate: DeliveryMethodTVControllerDelegate) {
        api.requestByModel(model: model, method: MethodApi.updateDeliveryMethod, completion: delegate.resultOfUpdateDeliveryMethod(for:))
    }
    // получение начисление по квитанции
    func getCalculationsByInvoiceId(id: Int, delegate: InvoiceDetailsInfoTableViewControllerDelegate){
        api.requestById(id: id, method: MethodApi.getCalculationsByInvoiceId, completion: delegate.setCalculations(calculations:))
    }
    
    func getStateApplePay(model: RequestOfPayModel, delegate: ContractDetailsInfoTVControllerDelegate) {
        api.requestById(id: model.id, method: MethodApi.getStateOfPayment, completion: delegate.navigationToResultOfPayment(for:))
    }
    
    // получение платежей по договору
    func getPaymentsByContractId(id: Int, delegate: PaymentsTVControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.getPaymentsByContractId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по квитанции
    func getPaymentsByInvoiceId(id: Int, delegate: InvoiceDetailsInfoTableViewControllerDelegate) {
        api.requestById(id: id, method: MethodApi.getPaymentsByInvoiceId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по договору
    func getInvoicesByContractId(id: Int, delegate: InvoicesTableViewControllerUserDelegate) throws {
        api.requestById(id: id, method: MethodApi.getInvoicesByContractId, completion: delegate.setInvoices(invoices:))
    }
    
    // отправка платежного документа
    func sendInvoiceByEmail(id: Int, delegate: InvoicesTableViewControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.sendInoicesByUserId, completion: delegate.responseSend(result:))
    }
    
    func sendInvoiceByEmail(model: SendInvoiceModel, delegate: InvoicesTableViewControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.sendInoicesByEmail, completion: delegate.responseSend(result:))
    }
    
    // получение приборов учета по договору
    func getDevicesByContractId(id: Int, delegate: DevicesTVControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.getDevicesByContractId, completion: delegate.setDevices(devices:))
    }
    
    // получение шаблона для передачи показаний
    func getReceivedDataAddNewTemplatesByDeviceId(id: Int, delegate: ReceivedDataAddNewTemplateTVControllerOneStepDelegate) {
        api.requestById(id: id, method: MethodApi.getTemplateAddNew, completion: delegate.setData(model:))
    }
    
    // получение показаний по прибору учета
    func getReceivedDataByDeviceId(id: Int, delegate: ReceivedDataTVControllerDelegate) {
        api.requestById(id: id, method: MethodApi.getReceivedData, completion: delegate.setData(model:))
    }
    
    func getReceivedDataVolumeByDeviceId(id: Int, delegate: ReceivedDataChartViewControllerDelegate) {
        api.requestById(id: id, method: MethodApi.getReceivedDateVolumesForChart, completion: delegate.setData(model:))
    }
    
    //
    func sendReceivedData(model: [ReceivedDataOfSendingModel], delegate: ReceivedDataAddNewTemplateTVControllerDelegate) {
        api.requestByModel(model: model, method: MethodApi.receivedDataAddNew, completion: delegate.resultOfSending(result:))
    }
    
    func receivedDataDelete(id: Int, delegate: ReceivedDataTVControllerDelegate) {
        api.requestById(id: id, method: MethodApi.receivedDataDelete, completion: delegate.resultOfDelete(result:))
    }
    
    // получение деталей по договору
    func getContractById(id: Int, delegate: ContractDetailsInfoTVControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
    func getContractById(delegate: ContractDetailsInfoTVControllerUserDelegate) {
        api.requestById(id: uds.getCurrentContract()!, method: MethodApi.getContract, completion: delegate.setContractById(contract:))
    }
    
    // получение профиля
    func getProfileById(delegate: ProfileTVControllerUserDelegate) {
        api.requestByToken(method: MethodApi.getUser, completion: delegate.setProfile(profile:))
    }
    
    // проверка email
    func checkByEmail(model: UserEmailModel, delegate: RecoveryPasswordTVControllerUserDelegate){
        api.requestByModel(model: model, method: MethodApi.checkEmail, completion: delegate.resultOfCheckEmail(result:))
    }
    
    // регистрация профиля
    func signUp(model: SingUpModel, delegate: SignUpTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.createUser, completion: delegate.resultOfCreateUser(result:))
    }
    
    // update user
    func updateUser(model: UserModel, delegate: ProfileTVControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.updateUser, completion: delegate.resultOfSaveProfile(result:))
    }
    
    // восстановление пароля
    func passwordRecovery(model: UserEmailModel, delegate: RecoveryPasswordTVControllerUserDelegate){
        api.requestByModel(model: model, method: MethodApi.passwordRecovery, completion: delegate.resultOfPassordRecovery(result:))
    }
    
    func passwordChange(model: PasswordChangeModel, delegate: ChangePasswordTVControllerDelegate){
        api.requestByModel(model: model, method: MethodApi.passwordChange, completion: delegate.responseOfChange(result:))
    }
    
    // получение способов доставки
    func getDeliveryOfInvoices(delegate: DeliveryMethodTVControllerDelegate) {
        api.requestByToken(method: MethodApi.getDeliveryOfInvoice, completion: delegate.setData(for:))
    }
    
    func loadSaldoContract(id: Int, label: UILabel) {
        api.requestById(id: id, method: MethodApi.getContractSaldoById) { (response: ResultModel<Decimal>) in
            guard let decData = response.data,
                  let text = decData.toString() else { return }
        label.text = formatRusCurrency(text)
        }
    }
    
    func getContractStatus(id: Int, status: UITableViewCell, value: UILabel){
        api.requestById(id: id, method: MethodApi.getContractStatusById) { (model: ResultModel<ContractStatusModel>) in
            status.textLabel?.text = model.data!.statusName
            value.text = formatRusCurrency(model.data!.value)
        }
    }
}
