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
            // Use an in memory service for testing. You would probably implement a CoreData or SQLite service here.
            container.register(.Singleton) { InMemoryDataService() as DataServiceProtocol }
            
            container.register(.Singleton) { AlamofireImageService(imageDownloader: ImageDownloader()) as ImageDownloadService }
            container.register(.Singleton) { ZombieRepository(dataService: try! container.resolve() as DataServiceProtocol) as Repository<Zombie> }
            container.register(.Singleton) { ZombieService(zombieRepository: try! container.resolve() as Repository<Zombie>) as ZombieServiceProtocol }
        }
    }
}
