//
//  ApiServiceProtocol.swift
//  mpges.lk
//
//  Created by Timur on 15.12.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol: class {
    
    func requestByModel<T: Decodable, M: Encodable>(model: M, requestMethod: MyHTTPMethod, method: String, completion: @escaping (T) -> Void)
    func requestById<T: Decodable>(id: Int, method: String, completion: @escaping(T) -> Void)
    func requestByToken<T: Decodable>(method: String, completion: @escaping(T) -> Void)

}
