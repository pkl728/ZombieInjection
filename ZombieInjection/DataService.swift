//
//  DataService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/10/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    func getZombie(_ id: Int) -> Zombie?
    func getZombie(_ predicate: (Zombie) throws -> Bool) -> Zombie?
    func getAllZombies() -> Array<Zombie>?
    func getZombies(_ predicate: (Zombie) throws -> Bool) -> Array<Zombie>?
    func containsZombie(_ predicate: (Zombie) throws -> Bool) -> Bool
    func insertZombie(_ zombie: Zombie) -> Void
    func insertZombies(_ zombie: Array<Zombie>) -> Void
    func deleteZombie(_ zombie: Zombie) -> Void
    func deleteZombies(_ predicate: (Zombie) throws -> Bool) -> Void
    func deleteAllZombies() -> Void
    func countZombies() -> Int
    func countZombies(_ predicate: (Zombie) throws -> Bool) -> Int
    func updateZombie(_ zombie: Zombie) -> Void
}
