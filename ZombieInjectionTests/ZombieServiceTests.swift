//
//  ZombieServiceTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/27/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest
import Bond

@testable import ZombieInjection
class ZombieServiceTests: XCTestCase {

    private var zombieRepository: Repository<Zombie>!
    private var zombieService: ZombieServiceProtocol!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.zombieRepository = ZombieRepositoryMock()
        self.zombieService = ZombieService(zombieRepository: self.zombieRepository)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.zombieRepository.deleteAll()
    }
    
    func testFetchZombies() {
        // Arrange
        // Act
        self.zombieService.fetchZombies()
        
        // Assert
        XCTAssert(self.zombieRepository.count() > 0)
    }
    
    func testGetZombies() {
        // Arrange
        // Act
        let zombies = self.zombieService.getAllZombies()
        
        // Assert
        XCTAssert(zombies?.count == 3)
    }
    
    func testGetZombiesIfNoZombies() {
        // Arrange
        self.zombieRepository.deleteAll()
        
        // Act
        let zombies = self.zombieService.getAllZombies()
        
        // Assert
        XCTAssert(zombies?.count == 0)
    }
    
    func testUpdateZombie() {
        // Arrange
        let zombie = self.zombieRepository.get(0)
        zombie?.name.value = "Test"
        
        // Act
        self.zombieService.update(zombie!)
        
        // Assert
        XCTAssert(self.zombieRepository.get(0)?.name.value == "Test")
    }
    
    func testUpdateWithNonExistentZombieDoesNothing() {
        // Arrange
        let badZombie = Zombie(id: -1, name: "Bad", imageUrlAddress: nil)
        
        // Act
        self.zombieService.update(badZombie)
        
        // Assert
        XCTAssert(self.zombieRepository.count() == 3)
        XCTAssert(self.zombieRepository.get(0)?.name.value == "First")
        XCTAssert(self.zombieRepository.get(1)?.name.value == "Second")
        XCTAssert(self.zombieRepository.get(2)?.name.value == "Third")
    }
}
