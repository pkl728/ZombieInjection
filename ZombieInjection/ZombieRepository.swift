//
//  ZombieRepository.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class ZombieRepository: Repository<Zombie> {
    
    typealias T = Zombie
    
    private var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    override func get(_ id: Int) -> T? {
        return self.dataService.getZombie(id)
    }
    
    override func get(_ predicate: (T) throws -> Bool) -> T? {
        return self.dataService.getZombie(predicate)
    }
    
    override func getAll() -> Array<T>? {
        return self.dataService.getAllZombies()
    }
    
    override func getAll(_ predicate: (T) throws -> Bool) -> Array<T>? {
        return self.dataService.getZombies(predicate)
    }
    
    override func contains(_ predicate: (T) throws -> Bool) -> Bool {
        return self.dataService.containsZombie(predicate)
    }
    
    override func insert(_ zombie: T) {
        self.dataService.insertZombie(zombie)
    }
    
    override func insertAll(_ zombies: Array<T>) {
        self.dataService.insertZombies(zombies)
    }
    
    override func delete(_ zombie: T) {
        self.dataService.deleteZombie(zombie)
    }
    
    override func deleteAll() {
        self.dataService.deleteAllZombies()
    }
    
    override func deleteAll(_ predicate: (T) throws -> Bool) {
        self.dataService.deleteZombies(predicate)
    }
    
    override func update(_ zombie: T) {
        self.dataService.updateZombie(zombie)
    }
    
    override func count() -> Int {
        return self.dataService.countZombies()
    }
    
    override func count(_ predicate: (T) throws -> Bool) -> Int {
        return self.dataService.countZombies(predicate)
    }
}
