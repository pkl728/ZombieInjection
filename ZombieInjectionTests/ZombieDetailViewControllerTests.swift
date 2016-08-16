//
//  ZombieDetailViewControllerTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest

@testable import ZombieInjection
class ZombieDetailViewControllerTests: XCTestCase {
    
    var mainViewController: ZombieListViewController!
    var detailViewController: ZombieDetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.mainViewController = storyboard.instantiateViewController(withIdentifier: "ZombieList") as! ZombieListViewController
        self.detailViewController = storyboard.instantiateViewController(withIdentifier: "ZombieDetail") as! ZombieDetailViewController
        mainViewController.viewModel.zombieService = ZombieServiceMock(zombieRepository: ZombieRepositoryMock())
        
        _ = mainViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDetailSeguePassesDataToDetailViewController() {
        // Arrange
        let targetSegue: UIStoryboardSegue = UIStoryboardSegue(identifier: "ShowZombieDetails", source: mainViewController, destination: detailViewController)
        self.mainViewController.zombieTableView.selectRow(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        // Act
        mainViewController.prepare(for: targetSegue, sender: nil)
        
        // Assert
        XCTAssertEqual("First", detailViewController.viewModel.zombie.name.value)
    }
    
    func testZombieDetailIsShown() {
        // Arrange
        let detailZombie = Zombie(id: 0, name: "Test", imageUrlAddress: nil)
        let viewModel = ZombieDetailViewModel(zombie: detailZombie, zombieService: ZombieServiceMock(zombieRepository: ZombieRepositoryMock()), goBackCallBack: { })
        detailViewController.viewModel = viewModel
        _ = detailViewController.view
        
        // Act
        detailViewController.viewDidLoad()
        
        // Assert
        XCTAssertEqual("Test", detailViewController.zombieNameTextField.text.value)
    }
    
    func testSaveButtonExecutes() {
        // Arrange
        var goBackCalled = false
        let detailZombie = Zombie(id: 0, name: "Test", imageUrlAddress: nil)
        let viewModel = ZombieDetailViewModel(zombie: detailZombie, zombieService: ZombieServiceMock(zombieRepository: ZombieRepositoryMock()), goBackCallBack: { goBackCalled = true })
        detailViewController.viewModel = viewModel

        // Act
        detailViewController.saveAction(goBackCalled)
        
        // Assert
        XCTAssertEqual(true, goBackCalled)
    }
}
