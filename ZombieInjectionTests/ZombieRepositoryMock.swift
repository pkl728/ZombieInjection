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
class ZombieRepositoryMock: ZombieRepositoryProtocol {
    
    private var dataService: ZombieDataServiceProtocol
    
    init() {
        // Just use the InMemoryDataService for testing purposes.
        self.dataService = InMemoryZombieDataService()
        self.dataService.deleteAll()
        self.dataService.insertAll(Array<Zombie>([ Zombie(id: 0, name: "First", imageUrlAddress: "http://test.com"),
                                                Zombie(id: 1, name: "Second", imageUrlAddress: "http://test.com"),
                                                Zombie(id: 2, name: "Third", imageUrlAddress: "http://test.com") ]))
    }
    
    func get(_ id: Int) -> Zombie? {
        return self.dataService.get(id)
    }
    
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie? {
        return self.dataService.get(predicate)
    }
    
    func getAll() -> Array<Zombie>? {
        return self.dataService.getAll()
    }
    
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>? {
        return self.dataService.getAll(predicate)
    }
    
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool {
        return self.dataService.contains(predicate)
    }
    
    func insert(_ zombie: Zombie) {
        self.dataService.insert(zombie)
    }
    
    func insertAll(_ zombies: Array<Zombie>) {
        self.dataService.insertAll(zombies)
    }
    
    func delete(_ zombie: Zombie) {
        self.dataService.delete(zombie)
    }
    
    func deleteAll(_ predicate: (Zombie) throws -> Bool) {
        self.dataService.deleteAll(predicate)
    }
    
    func deleteAll() {
        self.dataService.deleteAll()
    }
    
    func update(_ zombie: Zombie) {
        self.dataService.update(zombie)
    }
    
    func count() -> Int {
        return self.dataService.count()
    }
    
    func count(_ predicate: (Zombie) throws -> Bool) -> Int {
        return self.dataService.count(predicate)
    }
}
