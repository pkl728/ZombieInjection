//
//  ZombieDetailViewModel.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Foundation

class ZombieDetailViewModel {
    
    var zombie: Zombie
    var zombieService: ZombieServiceProtocol
    var zombieRepository: ZombieRepositoryProtocol
    var goBackCallBack: (() -> ())
    
    init(zombie: Zombie, zombieService: ZombieServiceProtocol, zombieRepository: ZombieRepositoryProtocol, goBackCallBack: @escaping (() -> ()))
    {
        self.zombie = zombie
        self.zombieService = zombieService
        self.zombieRepository = zombieRepository
        self.goBackCallBack = goBackCallBack
    }
    
    func save() {
        self.zombieRepository.update(zombie)
        self.goBackCallBack()
    }
    
    func save(unmanagedZombie: Zombie?) {
        guard let zombieToSave = unmanagedZombie else {
            self.goBackCallBack()
            return
        }
        self.zombieRepository.update(zombieToSave)
        self.goBackCallBack()
    }
}
