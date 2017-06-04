//
//  InMemoryDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class InMemoryDataService<ItemType: Persistable>: AnyDataService<ItemType> {
    
    private var items = Array<ItemType>()
    
    override func get(_ id: Int) -> ItemType? {
        return get({$0.id == id})
    }
    
    override func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
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
    
    override func getAll() -> Array<ItemType>? {
        return self.items
    }
    
    override func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        guard let items = try? self.items.filter(predicate) else {
            return nil
        }
        return items
    }
    
    override func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        var containsItem = false
        do {
            containsItem = try self.items.contains(where: predicate)
        }
        catch {
            print("Problem getting item exist")
        }
        return containsItem
    }
    
    override func insert(_ item: ItemType) {
        self.items.append(item)
    }
    
    override func insertAll(_ itemsToInsert: Array<ItemType>) {
        self.items.append(contentsOf: itemsToInsert)
    }
    
    override func delete(_ item: ItemType) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.remove(at: foundIndex)
    }
    
    override func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        guard let itemsToRemove = try? self.items.filter(predicate) else {
            return
        }
        
        for item in itemsToRemove {
            delete(item)
        }
    }
    
    override func deleteAll() {
        self.items.removeAll()
    }
    
    override func update(_ item: ItemType) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.insert(item, at: foundIndex)
    }
    
    override func count() -> Int {
        return self.items.count
    }
    
    override func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        guard let itemsToCount = try? self.items.filter(predicate) else {
            return 0
        }
        
        return itemsToCount.count
    }
}
