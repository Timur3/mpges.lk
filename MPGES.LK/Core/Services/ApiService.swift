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
                
                if let result = response.value {
                    let myResponse = try! JSONDecoder().decode(AuthResultModel.self, from: result)
                    DispatchQueue.main.async {
                        completion(myResponse)
                    }
                    debugPrint(myResponse)
                } else
                {
                    print(Error.self)
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
                
                if let result = response.value {
                    let myResponse = try! JSONDecoder().decode(PaymentModel.self, from: result)
                    DispatchQueue.main.async {
                        completion(myResponse)
                    }
                    debugPrint(myResponse)
                } else
                {
                    print(Error.self)
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
                
                if let result = response.value {
                    let myResponse = try! JSONDecoder().decode(PaymentsModelRoot.self, from: result)
                    DispatchQueue.main.async {
                        completion(myResponse.data)
                    }
                    debugPrint(myResponse)
                } else
                {
                    print(Error.self)
                }
            }
        }
    }
}
