//
//  DataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/10/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol ZombieDataServiceProtocol: class {
    func get(_ id: Int) -> Zombie?
    func get(_ predicate: (Zombie) throws -> Bool) -> Zombie?
    func getAll() -> Array<Zombie>?
    func getAll(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>?
    func contains(_ predicate: (Zombie) throws -> Bool) -> Bool
    func insert(_ item: Zombie) -> Void
    func insertAll(_ itemsToInsert: Array<Zombie>) -> Void
    func delete(_ item: Zombie) -> Void
    func deleteAll(_ predicate: (Zombie) throws -> Bool) -> Void
    func deleteAll() -> Void
    func count() -> Int
    func count(_ predicate: (Zombie) throws -> Bool) -> Int
    func update(_ item: Zombie) -> Void
}
