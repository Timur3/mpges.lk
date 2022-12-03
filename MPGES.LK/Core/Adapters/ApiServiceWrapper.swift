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
    var mainCoordinator: MainCoordinator?
    
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
    func updateDeliveryMethod(model: UpdateDeliveryMethodModel, delegate: InvoiceDeliveryMethodTVControllerDelegate) {
        api.requestByModel(model: model, method: MethodApi.updateDeliveryMethod, completion: delegate.resultOfUpdateDeliveryMethod(for:))
    }
    
    func getStateApplePay(model: RequestOfPayModel, delegate: ContractDetailsInfoTVControllerDelegate) {
        api.requestById(id: model.id, method: MethodApi.getStateOfPayment, completion: delegate.navigationToResultOfPayment(for:))
    }
    
    // получение платежей по договору
    func getPaymentsByContractId(id: Int, delegate: PaymentsViewController) {
        api.requestById(id: id, method: MethodApi.getPaymentsByContractId, completion: delegate.setPayments(payments:))
    }
    
    // получение платежей по договору
    func getInvoicesByContractId(id: Int, delegate: InvoicesViewControllerUserDelegate) throws {
        api.requestById(id: id, method: MethodApi.getInvoicesByContractId, completion: delegate.setInvoices(invoices:))
    }
    
    // отправка платежного документа
    func sendInvoiceByEmail(id: Int, delegate: InvoicesViewControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.sendInoicesByUserId, completion: delegate.responseSend(result:))
    }
    
    func sendInvoiceByEmail(model: SendInvoiceModel, delegate: InvoicesViewControllerUserDelegate) {
        api.requestByModel(model: model, method: MethodApi.sendInoicesByEmail, completion: delegate.responseSend(result:))
    }
    
    // получение приборов учета по договору
    func getDevicesByContractId(id: Int, delegate: DevicesViewControllerUserDelegate) {
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
        api.requestById(id: id, method: MethodApi.getContract, completion: delegate.setContractById(for:))
    }
    
    func getContractById(delegate: ContractDetailsInfoTVControllerUserDelegate) {
        api.requestById(id: uds.getCurrentContract()!, method: MethodApi.getContract, completion: delegate.setContractById(for:))
    }
    
    // получение профиля
    func getProfileById(delegate: ProfileTVControllerUserDelegate) {
        api.requestByToken(method: MethodApi.getUser, completion: delegate.setProfile(profile:))
    }
    
    // проверка email
    func checkByEmail(model: EmailModel, delegate: PasswordRecoveryTVControllerUserDelegate){
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
    func passwordRecovery(model: EmailModel, delegate: PasswordRecoveryTVControllerUserDelegate){
        api.requestByModel(model: model, method: MethodApi.passwordRecovery, completion: delegate.resultOfPasswordRecovery(result:))
    }
    
    func passwordChange(model: PasswordChangeModel, delegate: PasswordChangeTVControllerDelegate){
        api.requestByModel(model: model, method: MethodApi.passwordChange, completion: delegate.responseOfChange(result:))
    }
    
    func passwordReset(model: PasswordResetModel, delegate: PasswordResetTVControllerDelegate){
        api.requestByModel(model: model, method: MethodApi.passwordReset, completion: delegate.responseOfReset(result:))
    }
    
    // получение способов доставки
    func getDeliveryOfInvoices(delegate: InvoiceDeliveryMethodTVControllerDelegate) {
        api.requestByToken(method: MethodApi.getDeliveryOfInvoice, completion: delegate.setData(for:))
    }
    
    func loadSaldoContract(id: Int, label: UILabel) {
        api.requestById(id: id, method: MethodApi.getContractSaldoById) { (response: ResultModel<Decimal>) in
            guard let decData = response.data,
                  let text = decData.toString() else { return }
        label.text = formatRusCurrency(text)
        }
    }
    
    func getContractStatus(id: Int, delegate: ContractDetailsInfoTVControllerUserDelegate){
        api.requestById(id: id, method: MethodApi.getContractStatusById, completion: delegate.setContractStatus(for:))
    }
    
    func getReceiptUrl(id: Int, delegate: PaymentsViewControllerUserDelegate) {
        api.requestById(id: id, method: MethodApi.getReceiptUrl, completion: delegate.navigationPaymentInfoForSafariService(for:))
    }
    
    func getOffices(delegate: OfficesViewControllerDelegate)
    {
        api.requestByToken(method: MethodApi.getOfficesMark, completion: delegate.setOffices(for:))
    }
    
    // запрос кода на удаление профиля
    func getCodeForDeleteUser(model: EmailModel, delegate: PageEnterCodeTVControllerDelegate) {
        api.requestByModel(model: model, method: MethodApi.sendCodeForDeleteUser, completion: delegate.responseAfterSendingCode(result:))
    }
    
    // запрос на удаление пользователя
    func userDelete(model: OtpVerificationModel, delegate: PageEnterCodeTVControllerDelegate) {
        api.requestByModel(model: model, method: MethodApi.deleteUser, completion: delegate.responseOfDeleteUser(result:))
    }
}
