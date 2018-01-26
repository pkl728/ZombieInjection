//
//  ZombieRealmDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 6/13/17.
//  Copyright © 2017 Patrick Lind. All rights reserved.
//

import Foundation
import RealmSwift

class ZombieRealmDataService: ZombieDataServiceProtocol {
    
    let realm = try! Realm()
    
    func get(_ id: Int) -> Zombie? {
        guard let object = realm.object(ofType: Zombie.RealmObject.self, forPrimaryKey: id) else {
            return nil
        }
        return object.originalValue()
    }
    
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
        guard let allItems = try? realm.objects(Zombie.RealmObject.self) else {
            return nil
        }
        var newItems: Array<Zombie> = []
        for var item in allItems {
            newItems.append(item.originalValue())
        }
        guard let itemToReturn = try? newItems.filter(predicate).first else {
            return nil
        }
        return itemToReturn
    }
    
    func getAll() -> Array<Zombie>? {
        var resultsToReturn: Array<Zombie> = []
        let results: Array<Zombie.RealmObject> = Array(realm.objects(Zombie.RealmObject.self))
        results.forEach {
            resultsToReturn.append($0.originalValue())
        }
        return resultsToReturn
    }
    
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        guard let results = try? realm.objects(Zombie.RealmObject.self) else {
            return nil
        }
        var resultsToReturn: Array<Zombie> = []
        for result in results {
            resultsToReturn.append(result.originalValue())
        }
        return resultsToReturn
    }
    
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool {
        
        guard let results = try? realm.objects(Zombie.RealmObject.self) else {
            return false
        }
        var resultsToCheck: Array<Zombie> = []
        for result in results {
            resultsToCheck.append(result.originalValue())
        }
        let isPresent = try? resultsToCheck.contains(where: predicate)
        return isPresent ?? false
    }
    
    func insert(_ item: Zombie) {
        try? realm.write {
            realm.add(item.realmObject)
        }
    }
    
    func insertAll(_ itemsToInsert: Array<Zombie>) {
        try? realm.write {
            var realmItemsToInsert: Array<Object> = []
            itemsToInsert.forEach {
                realmItemsToInsert.append($0.realmObject)
            }
            realm.add(realmItemsToInsert)
        }
    }
    
    func delete(_ item: Zombie) {
        try? realm.write {
            realm.delete(item.realmObject)
        }
    }
    
    func deleteAll(_ predicate: (Zombie) throws -> Bool) {
        guard let items = try? realm.objects(Zombie.RealmObject.self) else {
            return
        }
        try? realm.write {
            realm.delete(items)
        }
    }
    
    func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func update(_ item: Zombie) {
        try? realm.write {
            realm.add(item.realmObject, update: true)
        }
    }
    
    func count() -> Int {
        return realm.objects(Zombie.RealmObject.self).count
    }
    
    func count(_ predicate: (Zombie) throws -> Bool) -> Int {
        guard let items = try? realm.objects(Zombie.RealmObject.self) else {
            return 0
        }
        var itemsToCount: Array<Zombie> = []
        for item in items {
            itemsToCount.append(item.originalValue())
        }
        let count = try? itemsToCount.filter(predicate).count
        return count ?? 0
    }
}
