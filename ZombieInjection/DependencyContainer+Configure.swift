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
            // container.register(.singleton) { InMemoryZombieDataService() as ZombieDataServiceProtocol }
            container.register(.singleton) { ZombieRealmDataService() as ZombieDataServiceProtocol }
            container.register(.singleton) { ZombieRepository(zombieDataService: try! container.resolve() as ZombieDataServiceProtocol) as ZombieRepositoryProtocol }
            container.register(.singleton) { ZombieService(zombieRepository: try! container.resolve() as ZombieRepositoryProtocol) as ZombieServiceProtocol }
        }
    }
}
