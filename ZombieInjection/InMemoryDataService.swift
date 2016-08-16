//
//  InMemoryDataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class InMemoryDataService: DataServiceProtocol {
    
    private var zombies = Array<Zombie>()
    
    func getZombie(_ id: Int) -> Zombie? {
        return getZombie({$0.id == id})
    }
    
    func getZombie(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
        do {
            guard let foundIndex = try self.zombies.index(where: predicate) else {
                return nil
            }
            return self.zombies[foundIndex]
        }
        catch {
            print("Problem getting item array index")
        }
        return nil
    }
    
    func getAllZombies() -> Array<Zombie>? {
        return self.zombies
    }
    
    func getZombies(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        guard let items = try? self.zombies.filter(predicate) else {
            return nil
        }
        return items
    }
    
    func containsZombie(_ predicate: (Zombie) throws -> Bool) -> Bool {
        var containsItem = false
        do {
            containsItem = try self.zombies.contains(where: predicate)
        }
        catch {
            print("Problem getting item exist")
        }
        return containsItem
    }
    
    func insertZombie(_ zombie: Zombie) {
        self.zombies.append(zombie)
    }
    
    func insertZombies(_ zombies: Array<Zombie>) {
        self.zombies.append(contentsOf: zombies)
    }
    
    func deleteZombie(_ zombie: Zombie) {
        guard let foundIndex = self.zombies.index(where: {$0.id == zombie.id}) else {
            return
        }
        self.zombies.remove(at: foundIndex)
    }
    
    func deleteZombies(_ predicate: (Zombie) throws -> Bool) {
        guard let itemsToRemove = try? self.zombies.filter(predicate) else {
            return
        }
        
        for item in itemsToRemove {
            deleteZombie(item)
        }
    }
    
    func deleteAllZombies() {
        self.zombies.removeAll()
    }
    
    func updateZombie(_ zombie: Zombie) {
        guard let foundIndex = self.zombies.index(where: {$0.id == zombie.id}) else {
            return
        }
        self.zombies.insert(zombie, at: foundIndex)
    }
    
    func countZombies() -> Int {
        return self.zombies.count
    }
    
    func countZombies(_ predicate: (Zombie) throws -> Bool) -> Int {
        guard let itemsToCount = try? self.zombies.filter(predicate) else {
            return 0
        }
        
        return itemsToCount.count
    }
}
