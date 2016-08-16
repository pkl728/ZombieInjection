//
//  ZombieListViewControllerTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest

@testable import ZombieInjection
class ZombieListViewControllerTests: XCTestCase {
    
    var viewController: ZombieListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ZombieList") as! ZombieListViewController
        viewController.viewModel.zombieService = ZombieServiceMock(zombieRepository: ZombieRepositoryMock())
        
        _ = viewController.view // Force loading subviews and setting outlets
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasTitleViewNamedZombies() {
        // Arrange
        // Act
        let title = viewController.navigationItem.title

        // Assert
        XCTAssert(title == "Zombies")
    }
    
    func testHasSegueWithIdentifierZombieDetails() {
        // Arrange
        let segues = viewController.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        
        // Act
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == "ShowZombieDetails" })
        
        // Assert
        XCTAssert(filtered?.count > 0)
    }
}
