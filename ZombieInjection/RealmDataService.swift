//
//  RealmDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 6/13/17.
//  Copyright © 2017 Patrick Lind. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataService<ItemType: RealmPersistable>: RealmDataServiceProtocol {
    
    let realm = try! Realm()
    
    func get(_ id: Int) -> ItemType? {
        guard let object = realm.object(ofType: ItemType.RealmObject.self, forPrimaryKey: id) else {
            return nil
        }
        return object.originalValue()
    }
    
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
        guard let allItems = try? realm.objects(ItemType.RealmObject.self) else {
            return nil
        }
        var newItems: Array<ItemType> = []
        for var item in allItems {
            newItems.append(item.originalValue())
        }
        guard let itemToReturn = try? newItems.filter(predicate).first else {
            return nil
        }
        return itemToReturn
    }
    
    func getAll() -> Array<ItemType>? {
        var resultsToReturn: Array<ItemType> = []
        let results: Array<ItemType.RealmObject> = Array(realm.objects(ItemType.RealmObject.self))
        results.forEach {
            if let itemToAdd = $0.originalValue() as? ItemType {
                resultsToReturn.append(itemToAdd)
            }
        }
        return resultsToReturn
    }
    
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        guard let results = try? realm.objects(ItemType.RealmObject.self) else {
            return nil
        }
        var resultsToReturn: Array<ItemType> = []
        for result in results {
            resultsToReturn.append(result.originalValue())
        }
        return resultsToReturn
    }
    
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        
        guard let results = try? realm.objects(ItemType.RealmObject.self) else {
            return false
        }
        var resultsToCheck: Array<ItemType> = []
        for result in results {
            resultsToCheck.append(result.originalValue())
        }
        let isPresent = try? resultsToCheck.contains(where: predicate)
        return isPresent ?? false
    }
    
    func insert(_ item: ItemType) {
        try? realm.write {
            realm.add(item.realmObject)
        }
    }
    
    func insertAll(_ itemsToInsert: Array<ItemType>) {
        try? realm.write {
            var realmItemsToInsert: Array<Object> = []
            itemsToInsert.forEach {
                realmItemsToInsert.append($0.realmObject)
            }
            realm.add(realmItemsToInsert)
        }
    }
    
    func delete(_ item: ItemType) {
        try? realm.write {
            realm.delete(item.realmObject)
        }
    }
    
    func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        guard let items = try? realm.objects(ItemType.RealmObject.self) else {
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
    
    func update(_ item: ItemType) {
        try? realm.write {
            realm.add(item.realmObject, update: true)
        }
    }
    
    func count() -> Int {
        return realm.objects(ItemType.RealmObject.self).count
    }
    
    func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        guard let items = try? realm.objects(ItemType.RealmObject.self) else {
            return 0
        }
        var itemsToCount: Array<ItemType> = []
        for item in items {
            itemsToCount.append(item.originalValue())
        }
        let count = try? itemsToCount.filter(predicate).count
        return count ?? 0
    }
}
