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
            container.register(.singleton) { AlamofireImageService(imageDownloader: ImageDownloader()) as ImageDownloadServiceProtocol }
            // Use InMemoryDataService for testing and RealmDataService for Production.
            // let zombieDataService = InMemoryZombieDataService()
            let zombieDataService = ZombieRealmDataService()
            let zombieRepository = ZombieRepository(zombieDataService: zombieDataService)
            container.register(.singleton) { ZombieService(zombieRepository: zombieRepository) as ZombieServiceProtocol }
        }
    }
}
