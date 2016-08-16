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
    
    func get(_ id: Int) -> T? {
        fatalError(#function + " must be overridden")
    }
    
    func get(_ predicate: (T) throws -> Bool) -> T? {
        fatalError(#function + " must be overridden")
    }
    
    func getAll() -> Array<T>? {
        fatalError(#function + " must be overridden")
    }
    
    func getAll(_ predicate: (T) throws -> Bool) -> Array<T>? {
        fatalError(#function + " must be overridden")
    }
    
    func contains(_ predicate: (T) throws -> Bool) -> Bool {
        fatalError(#function + " must be overridden")
    }
    
    func insert(_ object: T) {
        fatalError(#function + " must be overridden")
    }
    
    func insertAll(_ objects: Array<T>) {
        fatalError(#function + " must be overridden")
    }
    
    func delete(_ object: T) {
        fatalError(#function + " must be overridden")
    }
    
    func deleteAll() {
        fatalError(#function + " must be overridden")
    }
    
    func deleteAll(_ predicate: (T) throws -> Bool) {
        fatalError(#function + " must be overridden")
    }
    
    func update(_ object: T) {
        fatalError(#function + " must be overridden")
    }
    
    func count() -> Int {
        fatalError(#function + " must be overridden")
    }
    
    func count(_ predicate: (T) throws -> Bool) -> Int {
        fatalError(#function + " must be overridden")
    }
}
