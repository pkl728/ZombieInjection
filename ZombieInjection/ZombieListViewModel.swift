//
//  ZombieListViewModel.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import Dip
import Foundation

class ZombieListViewModel {
    
    var zombieService: ZombieServiceProtocol!
    var imageDownloadService: ImageDownloadService!
    var tableMembers: ObservableArray<Zombie>

    init() {
        self.tableMembers = ObservableArray([])
    }
    
    func updateZombieList() {
        self.zombieService.fetchZombies()
        if let zombies: Array<Zombie> = zombieService.getAllZombies() {
            tableMembers = ObservableArray<Zombie>(zombies)
            print("Items in tableMembers: \(tableMembers.count)")
        }
    }
}