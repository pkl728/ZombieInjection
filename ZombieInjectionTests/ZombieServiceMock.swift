//
//  ZombieServiceMock.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/9/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

@testable import ZombieInjection
class ZombieServiceMock: ZombieServiceProtocol {
    private var zombieRepository: ZombieRepositoryMock
    
    init(zombieRepository: Repository<Zombie>) {
        self.zombieRepository = ZombieRepositoryMock()
    }
    
    func fetchZombies() {
        self.createFakeZombies()
    }
    
    func getAllZombies() -> Array<Zombie>? {
        return self.zombieRepository.getAll()
    }
    
    func update(_ zombie: Zombie) {
        zombieRepository.update(zombie)
    }
    
    private func createFakeZombies() {
        for index in 1...100 {
            let zombie = Zombie(id: index, name: "Zombie \(index)", imageUrlAddress: "https://test.com")
            self.zombieRepository.insert(zombie)
        }
    }
}
