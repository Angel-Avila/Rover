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
    func fetchDogs() -> Observable<[DogViewModel]>
}

class DogServices: DogProvider {
        
    func fetchDogs() -> Observable<[DogViewModel]> {
        return Observable.create { observable -> Disposable in
            
            observable.onNext([DogViewModel(name: "Pug", owner: "Juan", bio: "This dog is an amazing dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "pug")),
                               DogViewModel(name: "Bravo", owner: "Juan", bio: "He's a very brave dog. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "dog")),
                               DogViewModel(name: "Pupperino", owner: "Juan", bio: "He's a really small puppy. I really do love him a lot since he's my best friend. I really like going on walks with him", image: #imageLiteral(resourceName: "puppy"))])
        
            return Disposables.create()
        }
    }
}
