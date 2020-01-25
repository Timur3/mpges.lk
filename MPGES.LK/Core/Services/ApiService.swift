//
//  ApiService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()
    let baseURL: String
    let vershionApi: String
    
    var _userData = UserDataService()
    let options = Options()
    init() {
        baseURL = options.baseUrl
        vershionApi = options.versionApi
    }
    
    //func authApi(model: AuthModel, completion: @escaping (AuthResultModel) -> Bool) {
    func authApi(model: AuthModel, completion: @escaping (AuthResultModel) -> Void) {
        let method = "auth"
        
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .post,
               parameters: model,
               encoder: JSONParameterEncoder.default)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(AuthResultModel.self, from: value)
                    DispatchQueue.main.async {
                        completion(myResponse)
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getPaymnetById(paymentId: Int, completion: @escaping(PaymentModel) -> Void) {
        let method = "payment"
        
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .post,
               parameters: paymentId,
               encoder: JSONParameterEncoder.default)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(PaymentModel.self, from: value)
                    
                    DispatchQueue.main.async {
                        completion(myResponse)
                    }
                    debugPrint(myResponse)
                
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getPaymnetsByContractId(contractId: Int, completion: @escaping([PaymentModel]) -> Void) {
        let method = "payment/getbypackid/4" //"payment/getbypackid/"+String(contractId)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + (_userData.getToken() ?? "")
        ]
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .get,
               //parameters: "",
               //encoder: JSONParameterEncoder.default,
               headers: headers)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(PaymentsModelRoot.self, from: value)
                        DispatchQueue.main.async {
                            completion(myResponse.data)
                        }
                    debugPrint(myResponse)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getDevicesByContractId(contractId: Int, completion: @escaping(DevicesModelRoot) -> Void) {
        let method = "device/getbypackid/"+String(contractId)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + (_userData.getToken() ?? "")
        ]
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .get,
               headers: headers)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(DevicesModelRoot.self, from: value)
                        DispatchQueue.main.async {
                            completion(myResponse)
                        }
                    debugPrint(myResponse)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func CreateOrUpdateAccount(account: AccountModel) {
        let method = "user/createorupdate"
        
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .post,
               parameters: account,
               encoder: JSONParameterEncoder.default)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(DevicesModelRoot.self, from: value)
                        DispatchQueue.main.async {
                           // completion(myResponse.data)
                        }
                    debugPrint(myResponse)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getContractsByUserId(userId: Int, completion: @escaping([ContractModel]) -> Void) {
        let method = "contract/getbyuserid/1" //"payment/getbypackid/"+String(contractId)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + (_userData.getToken() ?? "")
        ]
        DispatchQueue.global().async {
        AF.request(self.baseURL+method,
               method: .get,
               //parameters: "",
               //encoder: JSONParameterEncoder.default,
               headers: headers)
            
            .responseData { response in
                debugPrint("print reponse")
                debugPrint(response)
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(ContractModelRoot.self, from: value)
                        DispatchQueue.main.async {
                            completion(myResponse.data)
                        }
                    debugPrint(myResponse)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
