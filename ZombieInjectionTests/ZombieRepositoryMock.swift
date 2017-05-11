//
//  RepositoryMock.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/27/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import Foundation

@testable import ZombieInjection
class ZombieRepositoryMock: Repository<Zombie> {
    
    private var dataService: DataServiceProtocol
    
    override init() {
        // Just use the InMemoryDataService for testing purposes.
        self.dataService = InMemoryDataService()
        self.dataService.deleteAllZombies()
        self.dataService.insertZombies(Array<Zombie>([ Zombie(id: 0, name: "First", imageURL: URL(string: "http://test.com")),
                                                       Zombie(id: 1, name: "Second", imageURL: URL(string: "http://test.com")),
                                                       Zombie(id: 2, name: "Third", imageURL: URL(string: "http://test.com")) ]))
    }
    
    override func get(_ id: Int) -> Zombie? {
        return self.dataService.getZombie(id)
    }
    
    override func get(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
        return self.dataService.getZombie(predicate)
    }
    
    override func getAll() -> Array<Zombie>? {
        return self.dataService.getAllZombies()
    }
    
    override func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        return self.dataService.getZombies(predicate)
    }
    
    override func contains(_ predicate: (Zombie) throws -> Bool) -> Bool {
        return self.dataService.containsZombie(predicate)
    }
    
    override func insert(_ zombie: Zombie) {
        self.dataService.insertZombie(zombie)
    }
    
    override func insertAll(_ zombies: Array<Zombie>) {
        self.dataService.insertZombies(zombies)
    }
    
    override func delete(_ zombie: Zombie) {
        self.dataService.deleteZombie(zombie)
    }
    
    override func deleteAll(_ predicate: (Zombie) throws -> Bool) {
        self.dataService.deleteZombies(predicate)
    }
    
    override func deleteAll() {
        self.dataService.deleteAllZombies()
    }
    
    override func update(_ zombie: Zombie) {
        self.dataService.updateZombie(zombie)
    }
    
    override func count() -> Int {
        return self.dataService.countZombies()
    }
    
    override func count(_ predicate: (Zombie) throws -> Bool) -> Int {
        return self.dataService.countZombies(predicate)
    }
}
