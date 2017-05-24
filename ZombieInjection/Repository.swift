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

class AnyDataServiceProtocol<U>: DataServiceProtocol {
    typealias T = U
    
    let _get: (Int) -> U?
    let _getWithPredicate: ((U) throws -> Bool) -> U?
    let _getAll: () -> Array<U>?
    let _getAllWithPredicate: ((U) throws -> Bool) -> Array<U>?
    let _contains: ((U) throws -> Bool) -> Bool
    let _insert: (U) -> Void
    let _insertAll: (Array<U>) -> Void
    let _delete: (U) -> Void
    let _deleteAllWithPredicate: ((U) throws -> Bool) -> Void
    let _deleteAll: () -> Void
    let _count: () -> Int
    let _countWithPredicate: ((U) throws -> Bool) -> Int
    let _update: (U) -> Void
    
    init<T: DataServiceProtocol>(base: T) where T.ItemType == U {
        self._get = base.get
        self._getWithPredicate = base.get
        self._getAll = base.getAll
        self._getAllWithPredicate = base.getAll
        self._contains = base.contains
        self._insert = base.insert
        self._insertAll = base.insertAll
        self._delete = base.delete
        self._deleteAllWithPredicate = base.deleteAll
        self._deleteAll = base.deleteAll
        self._count = base.count
        self._countWithPredicate = base.count
        self._update = base.update
    }
    
    func get(_ id: Int) -> U? {
        return _get(id)
    }
    
    func get(_ predicate: (U) throws -> Bool) -> U? {
        return _getWithPredicate(predicate)
    }
    
    func getAll() -> Array<U>? {
        return _getAll()
    }
    
    func getAll(_ predicate: (U) throws -> Bool) -> Array<U>? {
        return _getAllWithPredicate(predicate)
    }
    
    func contains(_ predicate: (U) throws -> Bool) -> Bool {
        return _contains(predicate)
    }
    
    func insert(_ item: U) {
        return _insert(item)
    }
    
    func insertAll(_ itemsToInsert: Array<U>) {
        return _insertAll(itemsToInsert)
    }
    
    func delete(_ item: U) {
        return _delete(item)
    }
    
    func deleteAll(_ predicate: (U) throws -> Bool) {
        return _deleteAllWithPredicate(predicate)
    }
    
    func deleteAll() {
        return _deleteAll()
    }
    
    func count() -> Int {
        return _count()
    }
    
    func count(_ predicate: (U) throws -> Bool) -> Int {
        return _countWithPredicate(predicate)
    }
    
    func update(_ item: U) {
        return _update(item)
    }
}

class Repository<T: Persistable>: RepositoryProtocol {
    
    private var dataService: AnyDataServiceProtocol<T>
    
    init(dataService: AnyDataServiceProtocol<T>) {
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
