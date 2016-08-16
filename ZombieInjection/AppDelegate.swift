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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]? = [:]) -> Bool {
        
        let zombieService = try! container.resolve() as ZombieServiceProtocol
        let imageDownloadService = try! container.resolve() as ImageDownloadService
        
        if let navViewController = self.window?.rootViewController as? UINavigationController {
                if let zombieListViewController = navViewController.topViewController as? ZombieListViewController {
                    zombieListViewController.viewModel.zombieService = zombieService
                    zombieListViewController.viewModel.imageDownloadService = imageDownloadService
            }
        }
        return true
    }
}
