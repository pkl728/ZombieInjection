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
}

struct ZombieService: ZombieServiceProtocol {
    
    private var zombieRepository: ZombieRepositoryProtocol
    
    init(zombieRepository: ZombieRepositoryProtocol) {
        self.zombieRepository = zombieRepository
    }
    
    func fetchZombies() {
        self.zombieRepository.deleteAll()
        self.createFakeZombies()
    }
    
    private func createFakeZombies() {
        var zombieArray: Array<Zombie> = []
        for index in 1...100 {
            let zombie = Zombie(id: index, name: "Zombie \(index)", imageUrlAddress: "http://stevensegallery.com/200/200")
            zombieArray.append(zombie)
        }
        self.zombieRepository.insertAll(zombieArray)
    }
}
