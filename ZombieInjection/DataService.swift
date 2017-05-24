//
//  DataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/10/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol DataServiceProtocol: class {
    associatedtype ItemType
    
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
