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
    
    var userData = UserDataService()
    let options = Options()
    
    init() {
        baseURL = options.baseUrl
        vershionApi = options.versionApi
    }
    
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

    func requestById<T: Decodable>(id: Int, method: String, completion: @escaping(T) -> Void) {
        
        let fullMethod = method + String(id)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + (userData.getToken() ?? "")
        ]
        DispatchQueue.global().async {
        AF.request(self.baseURL+fullMethod,
               method: .get,
               headers: headers)
            .responseData { response in
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(T.self, from: value)
                        DispatchQueue.main.async {
                            completion(myResponse)
                        }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func requestByToken<T: Decodable>(method: String, completion: @escaping(T) -> Void) {
        
        let fullMethod = method
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + (userData.getToken() ?? "")
        ]
        DispatchQueue.global().async {
        AF.request(self.baseURL+fullMethod,
               method: .get,
               headers: headers)
            .responseData { response in
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(T.self, from: value)
                        DispatchQueue.main.async {
                            completion(myResponse)
                        }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
