//
//  DataProviderProtocol.swift
//  mpges.lk
//
//  Created by Timur on 27.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import RealmSwift

protocol DataProviderProtocol {
    
    func getObjects<T: Object>() -> [T]
    func getObjects<T: Object>(predicate: NSPredicate) -> [T]
    func saveObjects<T: Object>(_ items: [T])
    func deleteObjects<T: Object>(_ item: T)
}
