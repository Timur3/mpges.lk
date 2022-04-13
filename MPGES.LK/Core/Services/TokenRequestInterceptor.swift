//
//  TokenRequestAdapter.swift
//  mpges.lk
//
//  Created by Timur on 16.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import Alamofire
import Atomics
import UIKit


public class TokenRequestInterceptor: RequestInterceptor {
    let userDataService = UserDataService.shared
    let baseURL = MethodApi.baseUrl
    let device = UIDevice.current.identifierForVendor!
    let semaphore = DispatchSemaphore(value: 1)
    
    private let lock = NSLock()
    private var isRefreshing = false
    var refreshToken: String? = nil
    
    var refToken: String {
        get {
            return userDataService.getRefreshToken() ?? ""
        }
    }
    var retryLimit: Int {
        get {
            return 3
        }
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        debugPrint("adapt")
        debugPrint(urlRequest.url?.path ?? "")
        let accessToken = userDataService.getToken() ?? ""
        //debugPrint(accessToken)
        
        if (!accessToken.isEmpty) {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        //lock.lock(); defer { lock.unlock() }
        // узнаю код ответ
        debugPrint("\(request.response?.statusCode ?? 0)")
        let statusCode = request.response?.statusCode
        let pathUrl = request.request?.url?.path.lowercased()
        let pathUrlRefreshToken = "/v2/"+MethodApi.refreshToken
        let pathUrlSignIn = "/v2/"+MethodApi.authApi
        debugPrint(pathUrl ?? "")
        
        //этап 1 если 401 и дергаю апи на обновление основного токена
        if (statusCode == 401) {
            
            debugPrint("retry")
            if (pathUrl == pathUrlRefreshToken || pathUrl == pathUrlSignIn){
                debugPrint("url == urlRefresh")
                self.userDataService.delToken()
                self.userDataService.setNotIsAuth()
                // todo выкинуть на окно авторизации и очистить токены
            } else {
                let isRefresh = ManagedAtomic<Bool>(false)
                if (isRefresh.compareExchange(expected: false, desired: true, ordering: .sequentiallyConsistent).exchanged) {
                    semaphore.wait()
                    // здесь обновляем токен и записываем
                    let model = RefreshTokenModel(refreshToken: refToken, deviceId: device.uuidString)
                    
                    let method = MethodApi.refreshToken
                    debugPrint("refreshToken")
                    AF.request(self.baseURL+method, method: .post, parameters: model, encoder: JSONParameterEncoder.default)
                        .responseData { response in
                            switch response.result {
                            case let .success(value):
                                let myResponse = try! JSONDecoder().decode(ResultModel<TokensModel>.self, from: value)
                                if (!myResponse.isError) {
                                    self.userDataService.setToken(token: myResponse.data!.accessToken)
                                    self.userDataService.setRefreshToken(token: myResponse.data!.refreshToken)
                                    self.userDataService.setIsAuth()
                                } else {
                                    self.userDataService.delToken()
                                    self.userDataService.setNotIsAuth()
                                }
                            case let .failure(error):
                                print(error)
                            }
                        }
                    
                    isRefresh.exchange(false, ordering: .sequentiallyConsistent)
                    semaphore.signal()
                } else {
                    while (isRefresh.load(ordering: .sequentiallyConsistent)) {
                        // ждемс обновления токена
                        debugPrint("ждемс обновления токена")
                    }
                }
                completion(.retry)
            }
        }
        //этап 2 если refreshtoken тоже вернул 401 ошибку, то
    }
    
    private func refreshToken<T:Decodable, M: Encodable>(model: M, completion: @escaping (T) -> Void) {
        //guard !isRefreshing else { return }
        //isRefreshing = true
        
        let method = MethodApi.refreshToken
        debugPrint("refreshToken")
        AF.request(self.baseURL+method, method: .post, parameters: model, encoder: JSONParameterEncoder.default)
            .responseData { response in
                switch response.result {
                case let .success(value):
                    let myResponse = try! JSONDecoder().decode(T.self, from: value)
                    completion(myResponse)
                case let .failure(error):
                    print(error)
                }
            }
        
        //        ApiService.shared.requestByModel(model: model, method: MethodApi.refreshToken) { (response: ResultModel<TokensModel>) in
        //            if !(response.isError == true) {
        //                self.userDataService.setToken(token: response.data!.accessToken)
        //                self.userDataService.setRefreshToken(token: response.data!.refreshToken)
        //                self.userDataService.setIsAuth()
        //            } else {
        //                self.userDataService.delToken()
        //                self.userDataService.setNotIsAuth()
        //            }
        //        }
    }
    
}
