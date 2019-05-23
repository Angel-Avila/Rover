//
//  Dog.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import CoreStore

final class Dog: CoreStoreObject {
    let name = Value.Required<String>("name", initial: "")
    let owner = Value.Required<String>("owner", initial: "")
    let bio = Value.Required<String>("bio", initial: "")
    let image = Value.Optional<Data>("image")
    
    func asDogViewViewModel() -> DogViewModel {
        let img: UIImage?
        
        if let data = image.value {
            img = UIImage(data: data, scale: 1.0)
        } else {
            img = nil
        }
        
        return DogViewModel(name: name.value, owner: owner.value, bio: bio.value, image: img)
    }
}

struct DogViewModel {
    let name: String
    let owner: String
    let bio: String
    let image: UIImage?
    
    init(name: String, owner: String, bio: String, image: UIImage?) {
        self.name = name
        self.owner = owner
        self.bio = bio
        self.image = image
    }
    
    init(fromDog dog: Dog) {
        let img: UIImage?
        
        if let data = dog.image.value {
            img = UIImage(data: data, scale: 1.0)
        } else {
            img = nil
        }
        
        self.init(name: dog.name.value, owner: dog.owner.value, bio: dog.bio.value, image: img)
    }
}

extension DogViewModel: Equatable {
    static func == (lhs: DogViewModel, rhs: DogViewModel) -> Bool {
        return lhs.name == rhs.name
    }
}

extension DogViewModel: Hashable {
}
