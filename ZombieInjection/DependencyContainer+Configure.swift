//
//  CompositionRoot.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/22/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import AlamofireImage
import Dip
import RealmSwift

extension DependencyContainer {
    
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.singleton) { AlamofireImageService(imageDownloader: ImageDownloader()) as ImageDownloadService }
            // Use InMemoryDataService for testing and RealmDataService for Production.
            let zombieDataService = RealmDataService<Zombie>()
            container.register(.singleton) { ZombieRepository(dataService: AnyDataService<Zombie>(base: zombieDataService)) as Repository<Zombie> }
            container.register(.singleton) { ZombieService(zombieRepository: try! container.resolve() as Repository<Zombie>) as ZombieServiceProtocol }
        }
    }
}
