//
//  TokenRequestAdapter.swift
//  mpges.lk
//
//  Created by Timur on 16.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


public class TokenRequestInterceptor2: RequestInterceptor {
    let userDataService = UserDataService.shared
    let baseURL = MethodApi.baseUrl
    let device = UIDevice.current.identifierForVendor!
    
    var accessToken: String {
        get {
            return userDataService.getToken() ?? ""
        }
    }
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
        
        if (!accessToken.isEmpty) {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }
        
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // узнаю код ответ
        debugPrint("\(request.response?.statusCode ?? 0)")
        let statusCode = request.response?.statusCode
        let pathUrl = request.request?.url?.path.lowercased()
        let pathUrlRefreshToken = "/v2/"+MethodApi.refreshToken
        
        //этап 1 если 401 и дергаю апи на обновление основного токена
        if (statusCode == 401) {
            debugPrint("retry")
            debugPrint(pathUrl ?? "")
            if (pathUrl == pathUrlRefreshToken){
                debugPrint("url == urlRefresh")
                self.userDataService.delToken()
                // todo выкинуть на окно авторизации и очистить токены
            } else {
                // здесь обновляем токен и записываем
                let model = RefreshTokenModel(refreshToken: refToken, deviceId: device.uuidString)
                
                refreshToken(model: model) { (response: ResultModel<TokensModel>) in
                    self.userDataService.setToken(response.data?.accessToken ?? "")
                    self.userDataService.setRefreshToken(response.data?.refreshToken ?? "")
                    self.userDataService.setIsAuth()
                }
                completion(.retry)
            }
        }
        //этап 2 если refreshtoken тоже вернул 401 ошибку, то
    }
    
    private func refreshToken<T:Decodable, M: Encodable>(model: M, completion: @escaping (T) -> Void) {
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
        
        //        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":"Bearer \(refreshToken!)"]).responseJSON { [weak self] response in
        //            guard let strongSelf = self else { return }
        //            if
        //                let json = response.result.value as? [String: Any],
        //                let accessToken = json["accessToken"] as? String
        //            {
        //                completion(true, accessToken)
        //            } else {
        //                completion(false, nil)
        //            }
        //            strongSelf.isRefreshing = false
        //        }
    }
    
}
