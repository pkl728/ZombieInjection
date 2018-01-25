//
//  ZombieDetailViewModelTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/9/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest

@testable import ZombieInjection
class ZombieDetailViewModelTests: XCTestCase {
    
    var zombieDetailViewModel: ZombieDetailViewModel!
    var zombieServiceMock: ZombieServiceMock!
    var zombieRepositoryMock: ZombieRepositoryMock!
    var zombieSelected: Zombie!
    var goBackCallBackCalled = false
    
    override func setUp() {
        super.setUp()
        
        zombieSelected = Zombie(id: 0, name: "Selected", imageUrlAddress: nil)
        zombieRepositoryMock = ZombieRepositoryMock()
        zombieRepositoryMock.deleteAll()
        zombieRepositoryMock.insert(zombieSelected)
        zombieServiceMock = ZombieServiceMock(zombieRepository: zombieRepositoryMock)
        zombieDetailViewModel = ZombieDetailViewModel(zombie: zombieSelected, zombieService: zombieServiceMock, zombieRepository: zombieRepositoryMock, goBackCallBack: { self.goBackCallBackCalled = true })
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.zombieRepositoryMock.deleteAll()
        self.goBackCallBackCalled = false
    }
    
    func testSaveUpdatesZombie() {
        // Arrange
        self.zombieSelected.name.value = "Updated"
        
        // Act
        self.zombieDetailViewModel.save()
        
        // Assert
        XCTAssert(self.zombieRepositoryMock.get(0)?.name.value == "Updated")
    }
    
    func testSaveExercisesGoBackCallBack() {
        // Arrange
        self.zombieSelected.name.value = "Updated"
        
        // Act
        self.zombieDetailViewModel.save()
        
        // Assert
        XCTAssert(self.goBackCallBackCalled)
    }
}
