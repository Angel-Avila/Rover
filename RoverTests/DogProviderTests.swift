//
//  RoverTests.swift
//  RoverTests
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Rover

class DogProviderTests: XCTestCase {
    
    var provider: DogProvider!
    
    override func setUp() {
        provider = DogServices()
    }
    
    func testFetchDogsNotEmpty() {
        let dogs = try! provider.fetchDogs().toBlocking().first()!
        
        // testing we get our hard-coded dogs
        // this would have to change to stubbing if we actually did network calls
        XCTAssert(!dogs.isEmpty)
    }
}
