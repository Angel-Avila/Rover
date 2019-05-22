//
//  DogProvider.swift
//  Rover
//
//  Created by Angel Avila on 5/22/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import RxSwift

protocol DogProvider {
    func fetchDogs() -> Observable<[Dog]>
}

class DogServices: DogProvider {
    
    func fetchDogs() -> Observable<[Dog]> {
        return Observable.create { observable -> Disposable in
            
            observable.onNext([Dog(name: "Pug", owner: "Juan", bio: "This dog is an amazing dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "pug")),
                               Dog(name: "Bravo", owner: "Juan", bio: "This dog is an amazing dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "dog")),
                               Dog(name: "Pupperino", owner: "Juan", bio: "This dog is an amazing dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "puppy")),])
        
            return Disposables.create()
        }
    }
}
