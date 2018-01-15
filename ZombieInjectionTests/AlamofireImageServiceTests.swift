//
//  AlamofireImageServiceTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/14/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import AlamofireImage
import Bond
import XCTest

@testable import ZombieInjection
class AlamofireImageServiceTests: XCTestCase {
    
    private var imageService: AlamofireImageService!
    private var imageDownloader: ImageDownloaderMock!
    
    override func setUp() {
        super.setUp()
        imageDownloader = ImageDownloaderMock()
        self.imageService = AlamofireImageService(imageDownloader: imageDownloader)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestImageForImageAlreadyFilledInReturnsImmediately() {
        // Arrange
        let zombie = Zombie(id: 0, name: "Test", imageUrlAddress: nil)
        let icon = UIImage()
        zombie.image = Observable(icon)
        
        // Act
        self.imageService.requestImage(forItem: zombie)
        
        // Assert
        XCTAssertEqual(zombie.image.value, icon)
    }
    
    func testRequestImageForNewImageProperlyDownloads() {
        // Arrange
        let zombie = Zombie(id: 0, name: "Test", imageUrlAddress: "http://test.com")
        self.imageDownloader.responseIsSuccess = true
        
        // Act
        self.imageService.requestImage(forItem: zombie)
        
        // Assert
        XCTAssertEqual(zombie.image.value, imageDownloader.image)
    }
    
    func testRequestImageForNewImageDoesNotSetImageIfFail() {
        // Arrange
        let zombie = Zombie(id: 0, name: "Test", imageUrlAddress: "http://test.com")
        self.imageDownloader.responseIsSuccess = false
        
        // Act
        self.imageService.requestImage(forItem: zombie)
        
        // Assert
        XCTAssertNil(zombie.image.value)
    }
}
