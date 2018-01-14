//
//  DataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/10/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol DataServiceProtocol: class {
    associatedtype ItemType: Persistable
    
    func get(_ id: Int) -> ItemType?
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType?
    func getAll() -> Array<ItemType>?
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>?
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool
    func insert(_ item: ItemType) -> Void
    func insertAll(_ itemsToInsert: Array<ItemType>) -> Void
    func delete(_ item: ItemType) -> Void
    func deleteAll(_ predicate: (ItemType) throws -> Bool) -> Void
    func deleteAll() -> Void
    func count() -> Int
    func count(_ predicate: (ItemType) throws -> Bool) -> Int
    func update(_ item: ItemType) -> Void
}

protocol RealmDataServiceProtocol: class {
    associatedtype ItemType: RealmPersistable
    
    func get(_ id: Int) -> ItemType?
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType?
    func getAll() -> Array<ItemType>?
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>?
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool
    func insert(_ item: ItemType) -> Void
    func insertAll(_ itemsToInsert: Array<ItemType>) -> Void
    func delete(_ item: ItemType) -> Void
    func deleteAll(_ predicate: (ItemType) throws -> Bool) -> Void
    func deleteAll() -> Void
    func count() -> Int
    func count(_ predicate: (ItemType) throws -> Bool) -> Int
    func update(_ item: ItemType) -> Void
}

class AnyDataService<ItemType: Persistable>: DataServiceProtocol {
    
    private let box: _AnyDataServiceBoxBase<ItemType>
    
    init<D: DataServiceProtocol>(base: D) where D.ItemType == ItemType {
        self.box = _AnyDataServiceBox(base)
    }
    
    func get(_ id: Int) -> ItemType? {
        return self.box.get(id)
    }
    
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
        return self.box.get(predicate)
    }
    
    func getAll() -> Array<ItemType>? {
        return self.box.getAll()
    }
    
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        return self.box.getAll(predicate)
    }
    
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        return self.box.contains(predicate)
    }
    
    func insert(_ item: ItemType) {
        return self.box.insert(item)
    }
    
    func insertAll(_ itemsToInsert: Array<ItemType>) {
        return self.box.insertAll(itemsToInsert)
    }
    
    func delete(_ item: ItemType) {
        return self.box.delete(item)
    }
    
    func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        return self.box.deleteAll(predicate)
    }
    
    func deleteAll() {
        return self.box.deleteAll()
    }
    
    func count() -> Int {
        return self.box.count()
    }
    
    func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        return self.box.count(predicate)
    }
    
    func update(_ item: ItemType) {
        return self.box.update(item)
    }
}

fileprivate class _AnyDataServiceBoxBase<T: Persistable>: DataServiceProtocol {
    typealias ItemType = T

    func get(_ id: Int) -> ItemType? {
        fatalError()
    }
    
    func get(_ predicate: (ItemType) throws -> Bool) -> ItemType? {
        fatalError()
    }
    
    func getAll() -> Array<ItemType>? {
        fatalError()
    }
    
    func getAll(_ predicate: (ItemType) throws -> Bool) -> Array<ItemType>? {
        fatalError()
    }
    
    func contains(_ predicate: (ItemType) throws -> Bool) -> Bool {
        fatalError()
    }
    
    func insert(_ item: ItemType) {
        fatalError()
    }
    
    func insertAll(_ itemsToInsert: Array<ItemType>) {
        fatalError()
    }
    
    func update(_ item: ItemType) {
        fatalError()
    }
    
    func delete(_ item: ItemType) {
        fatalError()
    }
    
    func deleteAll(_ predicate: (ItemType) throws -> Bool) {
        fatalError()
    }
    
    func deleteAll() {
        fatalError()
    }
    
    func count() -> Int {
        fatalError()
    }
    
    func count(_ predicate: (ItemType) throws -> Bool) -> Int {
        fatalError()
    }
}

fileprivate class _AnyDataServiceBox<T: DataServiceProtocol>: _AnyDataServiceBoxBase<T.ItemType> {
    
    let base: T
    init(_ base: T) {
        self.base = base
    }
    
    override func get(_ id: Int) -> T.ItemType? {
        return base.get(id)
    }
    
    override func get(_ predicate: (T.ItemType) throws -> Bool) -> T.ItemType? {
        return base.get(predicate)
    }
    
    override func getAll(_ predicate: (T.ItemType) throws -> Bool) -> Array<T.ItemType>? {
        return base.getAll(predicate)
    }
    
    override func getAll() -> Array<T.ItemType>? {
        return base.getAll()
    }
    
    override func contains(_ predicate: (T.ItemType) throws -> Bool) -> Bool {
        return base.contains(predicate)
    }
    
    override func insert(_ item: T.ItemType) {
        return base.insert(item)
    }
    
    override func insertAll(_ itemsToInsert: Array<T.ItemType>) {
        return base.insertAll(itemsToInsert)
    }
    
    override func update(_ item: T.ItemType) {
        return base.update(item)
    }
    
    override func delete(_ item: T.ItemType) {
        return base.delete(item)
    }
    
    override func deleteAll(_ predicate: (T.ItemType) throws -> Bool) {
        return base.deleteAll(predicate)
    }
    
    override func deleteAll() {
        return base.deleteAll()
    }
    
    override func count() -> Int {
        return base.count()
    }
    
    override func count(_ predicate: (T.ItemType) throws -> Bool) -> Int {
        return base.count(predicate)
    }
}
