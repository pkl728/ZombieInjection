//
//  RealmDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 6/13/17.
//  Copyright © 2017 Patrick Lind. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataService<ItemType: Persistable>: DataServiceProtocol where ItemType: Object {
    
    let realm = try! Realm()
    
    func get(_ id: Int) -> ItemType? {
        return realm.object(ofType: ItemType.self, forPrimaryKey: id)
    }
    
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
        guard let itemToGet = try? realm.objects(ItemType.self).filter(predicate).first else {
            return nil
        }
        return itemToGet
    }
    
    func getAll() -> Array<ItemType>? {
        let results = Array(realm.objects(ItemType.self))
        return results
    }
    
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        guard let results = try? realm.objects(ItemType.self).filter(predicate) else {
            return nil
        }
        return Array(results)
    }
    
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        guard let isPresent = try? realm.objects(ItemType.self).contains(where: predicate) else {
            return false
        }
        return isPresent
    }
    
    func insert(_ item: ItemType) {
        try? realm.write {
            realm.add(item)
        }
    }
    
    func insertAll(_ itemsToInsert: Array<ItemType>) {
        try? realm.write {
            realm.add(itemsToInsert)
        }
    }
    
    func delete(_ item: ItemType) {
        try? realm.write {
            realm.delete(item)
        }
    }
    
    func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        guard let itemsToDelete = try? realm.objects(ItemType.self).filter(predicate) else {
            return
        }
        try? realm.write {
            realm.delete(itemsToDelete)
        }
    }
    
    func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func update(_ item: ItemType) {
        try? realm.write {
            realm.add(item, update: true)
        }
    }
    
    func count() -> Int {
        return realm.objects(ItemType.self).count
    }
    
    func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        guard let count = try? realm.objects(ItemType.self).filter(predicate).count else {
            return 0
        }
        return count
    }
}
