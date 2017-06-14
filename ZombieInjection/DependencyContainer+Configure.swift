//
//  CompositionRoot.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/22/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import AlamofireImage
import Dip

extension DependencyContainer {
    
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.singleton) { AlamofireImageService(imageDownloader: ImageDownloader()) as ImageDownloadService }
            // Use an in memory service for testing. You would probably implement a CoreData or SQLite service here.
            let zombieInMemoryDataService = InMemoryDataService<Zombie>()
            container.register(.singleton) { ZombieRepository(dataService: AnyDataService<Zombie>(base: zombieInMemoryDataService)) as Repository<Zombie> }
            container.register(.singleton) { ZombieService(zombieRepository: try! container.resolve() as Repository<Zombie>) as ZombieServiceProtocol }
        }
    }
}
