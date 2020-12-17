//
//  TokenRequestAdapter.swift
//  mpges.lk
//
//  Created by Timur on 16.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import Alamofire


public class TokenRequestInterceptor: RequestInterceptor {
    var delegate: MainCoordinator?
    var accesToken: String {
        get {
            return UserDataService.shared.getToken() ?? ""
        }
    }
    var retryLimit: Int {
        get {
            return 3
        }
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        debugPrint(urlRequest.url?.path ?? "")
        debugPrint(urlRequest.url?.baseURL ?? "")
        debugPrint(urlRequest.url?.absoluteURL ?? "")
        
        if (!accesToken.isEmpty) {
            urlRequest.headers.add(.authorization(bearerToken: accesToken))
        }
        
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // узнаю код ответ
        debugPrint("\(request.response?.statusCode ?? 0)")
        let statusCode = request.response?.statusCode
        let pathUrl = request.request?.url?.path.lowercased()
        
        //этап 1 если 401 и дергаю апи на обновление основного токена
        if (statusCode == 401) {
            if (pathUrl == "/v2/auth/refreshtoken"){
                // todo выкинуть на окно авторизации и очистить токены
            } else {
                // здесь обновляем токен и записываем
                
            }
        }
        //этап 2 если refreshtoken тоже вернул 401 ошибку, то
    }
        
}
