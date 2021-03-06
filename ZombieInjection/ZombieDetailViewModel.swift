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
    var goBackCallBack: (() -> ())
    
    init(zombie: Zombie, zombieService: ZombieServiceProtocol, goBackCallBack: @escaping (() -> ()))
    {
        self.zombie = zombie
        self.zombieService = zombieService
        self.goBackCallBack = goBackCallBack
    }
    
    func save() {
        self.zombieService.update(zombie)
        self.goBackCallBack()
    }
    
    func save(unmanagedZombie: Zombie?) {
        guard let zombieToSave = unmanagedZombie else {
            self.goBackCallBack()
            return
        }
        self.zombieService.update(zombieToSave)
        self.goBackCallBack()
    }
}
