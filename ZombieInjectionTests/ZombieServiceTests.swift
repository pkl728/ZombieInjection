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

    private var zombieRepository: ZombieRepositoryProtocol!
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
}
