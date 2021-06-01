//
//  ApiService.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import Alamofire

class ApiService: ApiServiceProtocol {
    
    static let shared = ApiService()
    let baseURL: String
    let vershionApi: String
    let interceptor = TokenRequestInterceptor()
    
    init() {
        baseURL = MethodApi.baseUrl
        vershionApi = MethodApi.versionApi
    }
    
    class Connectivity {
        class var isConnectedToInternet: Bool {
            return NetworkReachabilityManager()?.isReachable ?? false
        }
    }
    
    func requestByModel<T: Decodable, M: Encodable>(model: M, requestMethod: MyHTTPMethod = .post, method: String, completion: @escaping (T) -> Void) {
        
        AF.request(self.baseURL+method, method: .post, parameters: model, encoder: JSONParameterEncoder.default, interceptor: interceptor)            
            .responseData { response in
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(T.self, from: value)
                    completion(myResponse)
                case let .failure(error):
                    debugPrint("requestByModel")
                    debugPrint(error)
                }
            }
    }
    
    func requestById<T: Decodable>(id: Int, method: String, completion: @escaping(T) -> Void) {
        
        let fullMethod = method + String(id)
        
        AF.request(self.baseURL+fullMethod, method: .get, interceptor: interceptor)
            .responseData { response in
                
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(T.self, from: value)
                    DispatchQueue.main.async {
                        completion(myResponse)
                    }
                case let .failure(error):
                    print("error")
                    print(error)
                }
            }
        
    }
    
    func requestByToken<T: Decodable>(method: String, completion: @escaping(T) -> Void) {
        
        let fullMethod = method
        AF.request(self.baseURL+fullMethod, method: .get, interceptor: interceptor)
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
