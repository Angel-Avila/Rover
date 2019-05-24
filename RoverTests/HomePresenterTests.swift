//
//  HomePresenterTests.swift
//  RoverTests
//
//  Created by Angel Avila on 5/24/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Rover

class MockProvider: DogProvider {
    
    static var pug = DogViewModel(name: "pug", owner: "Juan", bio: "This dog is an amazing dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: nil)
    
    func fetchDogs() -> Observable<[DogViewModel]> {
        return Observable.create { observable -> Disposable in
            
            observable.onNext([MockProvider.pug])
            
            return Disposables.create()
        }
    }
}

class HomePresenterTests: XCTestCase {
    
    var provider: DogProvider!
    var presenter: HomePresenter!
    
    override func setUp() {
        provider = MockProvider()
        presenter = HomePresenterImpl(withProvider: provider)
    }
    
    func testFetchPug() {
        let pug = try! provider.fetchDogs().toBlocking().first()!.first
        
        // testing we get the data of our dog right
        XCTAssertEqual(MockProvider.pug, pug)
    }
}
