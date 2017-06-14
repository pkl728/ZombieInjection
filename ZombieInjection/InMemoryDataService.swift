//
//  InMemoryDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class InMemoryDataService<ItemType>: DataServiceProtocol where ItemType: Persistable {
    
    private var items = Array<ItemType>()
    
    func get(_ id: Int) -> ItemType? {
        return get({$0.id == id})
    }
    
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
        do {
            guard let foundIndex = try self.items.index(where: predicate) else {
                return nil
            }
            return self.items[foundIndex]
        }
        catch {
            print("Problem getting item array index")
        }
        return nil
    }
    
    func getAll() -> Array<ItemType>? {
        return self.items
    }
    
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        guard let items = try? self.items.filter(predicate) else {
            return nil
        }
        return items
    }
    
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        var containsItem = false
        do {
            containsItem = try self.items.contains(where: predicate)
        }
        catch {
            print("Problem getting item exist")
        }
        return containsItem
    }
    
    func insert(_ item: ItemType) {
        self.items.append(item)
    }
    
    func insertAll(_ itemsToInsert: Array<ItemType>) {
        self.items.append(contentsOf: itemsToInsert)
    }
    
    func delete(_ item: ItemType) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.remove(at: foundIndex)
    }
    
    func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        guard let itemsToRemove = try? self.items.filter(predicate) else {
            return
        }
        
        for item in itemsToRemove {
            delete(item)
        }
    }
    
    func deleteAll() {
        self.items.removeAll()
    }
    
    func update(_ item: ItemType) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.insert(item, at: foundIndex)
    }
    
    func count() -> Int {
        return self.items.count
    }
    
    func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        guard let itemsToCount = try? self.items.filter(predicate) else {
            return 0
        }
        
        return itemsToCount.count
    }
}
