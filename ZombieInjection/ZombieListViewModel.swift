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
    
    var zombieService: ZombieServiceProtocol
    var imageDownloadService: ImageDownloadServiceProtocol
    var tableMembers: ObservableArray<Zombie>

    init(zombieService: ZombieServiceProtocol, imageDownloadService: ImageDownloadServiceProtocol) {
        self.zombieService = zombieService
        self.imageDownloadService = imageDownloadService
        self.tableMembers = ObservableArray([])
    }
    
    func updateZombieList() {
        self.zombieService.fetchZombies()
        if let zombies = zombieService.getAllZombies() {
            tableMembers = ObservableArray<Zombie>(zombies)
            print("Items in tableMembers: \(tableMembers.count)")
        }
    }
}
