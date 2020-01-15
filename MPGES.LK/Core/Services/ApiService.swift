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
               parameters: model, // or `userDictionary` because both conform to `Encodable`
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
}
