//
//  RepositoryProtocol.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/14/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol ZombieRepositoryProtocol: class {
    func get(_ id: Int) -> Zombie?
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie?
    func getAll() -> Array<Zombie>?
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>?
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool
    func insert(_ object: Zombie) -> Void
    func insertAll(_ object: Array<Zombie>) -> Void
    func delete(_ object: Zombie) -> Void
    func deleteAll(_ predicate: (Zombie) throws -> Bool) -> Void
    func deleteAll() -> Void
    func count() -> Int
    func count(_ predicate: (Zombie) throws -> Bool) -> Int
    func update(_ object: Zombie) -> Void
}

class ZombieRepository: ZombieRepositoryProtocol {
    
    private var zombieDataService: ZombieDataServiceProtocol
    
    init(zombieDataService: ZombieDataServiceProtocol) {
        self.zombieDataService = zombieDataService
    }
    
    func get(_ id: Int) -> Zombie? {
        return self.zombieDataService.get(id)
    }
    
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
        return self.zombieDataService.get(predicate)
    }
    
    func getAll() -> Array<Zombie>? {
        return self.zombieDataService.getAll()
    }
    
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        return self.getAll(predicate)
    }
    
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool {
        return self.zombieDataService.contains(predicate)
    }
    
    func insert(_ zombie: Zombie) {
        return self.zombieDataService.insert(zombie)
    }
    
    func insertAll(_ zombies: Array<Zombie>) {
        return self.zombieDataService.insertAll(zombies)
    }
    
    func delete(_ zombie: Zombie) {
        return self.zombieDataService.delete(zombie)
    }
    
    func deleteAll() {
        return self.zombieDataService.deleteAll()
    }
    
    func deleteAll(_ predicate: (Zombie) throws -> Bool) {
        return self.zombieDataService.deleteAll(predicate)
    }
    
    func update(_ zombie: Zombie) {
        return self.zombieDataService.update(zombie)
    }
    
    func count() -> Int {
        return self.zombieDataService.count()
    }
    
    func count(_ predicate: (Zombie) throws -> Bool) -> Int {
        return self.zombieDataService.count(predicate)
    }
}
