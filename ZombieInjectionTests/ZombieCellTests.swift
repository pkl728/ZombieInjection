//
//  ZombieCellTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest

@testable import ZombieInjection
class ZombieCellTests: XCTestCase {
    
    var cell: ZombieCell!
    var viewController: ZombieListViewController!
    var imageDownloader: ImageDownloaderMock!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ZombieList") as! ZombieListViewController
        let repository = ZombieRepositoryMock()
        imageDownloader = ImageDownloaderMock()
        imageDownloader.responseIsSuccess = true
        viewController.viewModel = ZombieListViewModel(zombieService: ZombieServiceMock(zombieRepository: repository), imageDownloadService: AlamofireImageService(imageDownloader: imageDownloader))
        
        _ = viewController.view // Force loading subviews and setting outlets
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCellDetailsAreFilledIn() {
        // Arrange
        // Act
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = viewController.zombieTableView.cellForRow(at: indexPath) as! ZombieCell
        
        // Assert
        XCTAssertEqual("First", cell.zombieNameLabel.text)
        XCTAssertEqual(imageDownloader.image, cell.zombieImageView.image)
    }
}
