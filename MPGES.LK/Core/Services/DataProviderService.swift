//
//  DataProviderService.swift
//  mpges.lk
//
//  Created by Timur on 27.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import RealmSwift

class DataProvaderService: DataProviderProtocol {
    
    func getObjects<T: Object>() -> [T]{
        var items = [T]()
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            items = Array(realm.objects(T.self))
            return items
        } catch {
            print(error)
            return items
        }
    }
    
    func saveObjects<T: Object>(_ items: [T]){
        do {
            let realm = try Realm()
            let oldItems = realm.objects(T.self)
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            try realm.write {
                realm.delete(oldItems)
                realm.add(items)
            }
        } catch {
            print(error)
        }
    }
}
