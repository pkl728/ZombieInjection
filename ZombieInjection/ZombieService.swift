//
//  ZombieService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/22/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

protocol ZombieServiceProtocol {
    func fetchZombies()
    func update(_ zombie: Zombie)
    func getAllZombies() -> Array<Zombie>?
}

struct ZombieService: ZombieServiceProtocol {
    private var zombieRepository: Repository<Zombie>
    
    init(zombieRepository: Repository<Zombie>) {
        self.zombieRepository = zombieRepository
    }
    
    func fetchZombies() {
        self.zombieRepository.deleteAll()
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
            let zombie = Zombie(id: index, name: "Zombie \(index)", imageUrlAddress: "http://stevensegallery.com/200/200")
            self.zombieRepository.insert(zombie)
        }
    }
}
