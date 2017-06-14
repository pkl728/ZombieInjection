//
//  RepositoryProtocol.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/14/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol RepositoryProtocol: class {
    associatedtype Object: Persistable

    func get(_ id: Int) -> Object?
    func get(_ predicate: (Object) throws -> Bool) -> Object?
    func getAll() -> Array<Object>?
    func getAll(_ predicate: (Object) throws -> Bool) -> Array<Object>?
    func contains(_ predicate: (Object) throws -> Bool) -> Bool
    func insert(_ object: Object) -> Void
    func insertAll(_ object: Array<Object>) -> Void
    func delete(_ object: Object) -> Void
    func deleteAll(_ predicate: (Object) throws -> Bool) -> Void
    func deleteAll() -> Void
    func count() -> Int
    func count(_ predicate: (Object) throws -> Bool) -> Int
    func update(_ object: Object) -> Void
}

class Repository<T: Persistable>: RepositoryProtocol {
    
    private var dataService: AnyDataService<T>
    
    init(dataService: AnyDataService<T>) {
        self.dataService = dataService
    }
    
    func get(_ id: Int) -> T? {
        return self.dataService.get(id)
    }
    
    func get(_ predicate: (T) throws -> Bool) -> T? {
        return self.dataService.get(predicate)
    }
    
    func getAll() -> Array<T>? {
        return self.dataService.getAll()
    }
    
    func getAll(_ predicate: (T) throws -> Bool) -> Array<T>? {
        return self.getAll(predicate)
    }
    
    func contains(_ predicate: (T) throws -> Bool) -> Bool {
        return self.dataService.contains(predicate)
    }
    
    func insert(_ object: T) {
        return self.dataService.insert(object)
    }
    
    func insertAll(_ objects: Array<T>) {
        return self.dataService.insertAll(objects)
    }
    
    func delete(_ object: T) {
        return self.dataService.delete(object)
    }
    
    func deleteAll() {
        return self.dataService.deleteAll()
    }
    
    func deleteAll(_ predicate: (T) throws -> Bool) {
        return self.dataService.deleteAll(predicate)
    }
    
    func update(_ object: T) {
        return self.dataService.update(object)
    }
    
    func count() -> Int {
        return self.dataService.count()
    }
    
    func count(_ predicate: (T) throws -> Bool) -> Int {
        return self.dataService.count(predicate)
    }
}
