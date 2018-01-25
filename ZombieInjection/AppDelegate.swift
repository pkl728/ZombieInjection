//
//  AppDelegate.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Dip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {    
    var window: UIWindow?
    
    private let container = DependencyContainer.configure()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let zombieService = try! container.resolve() as ZombieServiceProtocol
        let zombieRepository = try! container.resolve() as ZombieRepositoryProtocol
        let imageDownloadService = try! container.resolve() as ImageDownloadServiceProtocol
        
        if let navViewController = self.window?.rootViewController as? UINavigationController {
            if let zombieListViewController = navViewController.topViewController as? ZombieListViewController {
                let zombieListViewModel = ZombieListViewModel(zombieService: zombieService, zombieRepository: zombieRepository, imageDownloadService: imageDownloadService)
                zombieListViewController.viewModel = zombieListViewModel
            }
        }
        return true
    }
}
