//
//  ZombieListViewModelTests.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/9/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import XCTest

@testable import ZombieInjection
class ZombieListViewModelTests: XCTestCase {
    
    private var zombieRepository: Repository<Zombie>!
    private var zombieService: ZombieServiceProtocol!
    private var zombieListViewModel: ZombieListViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.zombieRepository = ZombieRepositoryMock()
        self.zombieService = ZombieServiceMock(zombieRepository: self.zombieRepository)
        self.zombieListViewModel = ZombieListViewModel()
        self.zombieListViewModel.zombieService = self.zombieService
    }
    
    override func tearDown() {
        super.tearDown()
        self.zombieRepository.deleteAll()
    }
    
    func testTableMembersGetInitializedToEmptyArray() {
        // Arrange
        // Act
        // Assert
        XCTAssert(self.zombieListViewModel.tableMembers.count == 0)
    }
    
    func testTableMembersGetUpdated() {
        // Arrange        
        // Act
        self.zombieListViewModel.updateZombieList()
        
        // Assert
        XCTAssert(self.zombieListViewModel.tableMembers.count == 103)
    }
}
