//
//  DataProviderService.swift
//  mpges.lk
//
//  Created by Timur on 27.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import RealmSwift

class DataProviderService: DataProviderProtocol {
    
    static let shared = DataProviderService()
    
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
    
    func getObjects<T: Object>(predicate: NSPredicate) -> [T]{
        var items = [T]()
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            items = Array(realm.objects(T.self).filter(predicate))
            return items
        } catch {
            print(error)
            return items
        }
    }
    
    func saveObjects<T: Object>(_ items: [T]){
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            for item in items {
                realm.beginWrite()
                realm.add(item, update: .all)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteObjects<T: Object>(_ item: T) {
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            let oldItem = realm.objects(T.self)
            
            realm.beginWrite()
            realm.delete(oldItem)
            try realm.commitWrite()
            
        } catch {
                print(error)
            }
        }
}
