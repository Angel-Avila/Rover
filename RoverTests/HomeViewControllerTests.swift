//
//  HomeViewControllerTests.swift
//  RoverTests
//
//  Created by Angel Avila on 5/24/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import XCTest
import RxSwift
@testable import Rover

class MockHomePresenter: HomePresenter {
    
    var provider: DogProvider!
    var fetchWasCalled = false
    
    init(withProvider provider: DogProvider) {
        self.provider = provider
    }
    
    func fetchDogs() -> Observable<[DogViewModel]> {
        fetchWasCalled = true
        return provider.fetchDogs()
    }
}

class HomeViewControllerTests: XCTestCase {

    var provider: DogProvider!
    var presenter: MockHomePresenter!
    var viewController: HomeViewController!
    
    override func setUp() {
        provider = MockProvider()
        presenter = MockHomePresenter(withProvider: provider)
        viewController = HomeViewController(withPresenter: presenter)
        // force load it
        _ = viewController.view
    }
    
    func testFetchWasCalled() {
        XCTAssert(presenter.fetchWasCalled)
    }
    
    func testCachedObjectsWereSaved() {
        XCTAssert(viewController.items.numberOfObjects() > 0)
    }
}
