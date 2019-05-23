//
//  HomePresenter.swift
//  Rover
//
//  Created by Angel Avila on 5/22/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenter {
    func fetchDogs() -> Observable<[DogViewModel]>
}

class HomePresenterImpl: HomePresenter {
    
    let provider: DogProvider!
    
    init(withProvider provider: DogProvider) {
        self.provider = provider
    }
    
    func fetchDogs() -> Observable<[DogViewModel]> {
        return provider.fetchDogs()
    }
}
