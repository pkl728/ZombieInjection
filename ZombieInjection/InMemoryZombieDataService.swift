//
//  InMemoryDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class InMemoryZombieDataService: ZombieDataServiceProtocol {
    
    private var items = Array<Zombie>()
    
    func get(_ id: Int) -> Zombie? {
        return get({$0.id == id})
    }
    
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
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
    
    func getAll() -> Array<Zombie>? {
        return self.items
    }
    
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        guard let items = try? self.items.filter(predicate) else {
            return nil
        }
        return items
    }
    
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool {
        var containsItem = false
        do {
            containsItem = try self.items.contains(where: predicate)
        }
        catch {
            print("Problem getting item exist")
        }
        return containsItem
    }
    
    func insert(_ item: Zombie) {
        self.items.append(item)
    }
    
    func insertAll(_ itemsToInsert: Array<Zombie>) {
        self.items.append(contentsOf: itemsToInsert)
    }
    
    func delete(_ item: Zombie) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.remove(at: foundIndex)
    }
    
    func deleteAll(_ predicate: (Zombie) throws -> Bool) {
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
    
    func update(_ item: Zombie) {
        guard let foundIndex = self.items.index(where: {$0.id == item.id}) else {
            return
        }
        self.items.insert(item, at: foundIndex)
    }
    
    func count() -> Int {
        return self.items.count
    }
    
    func count(_ predicate: (Zombie) throws -> Bool) -> Int {
        guard let itemsToCount = try? self.items.filter(predicate) else {
            return 0
        }
        
        return itemsToCount.count
    }
}
