//
//  HomeViewController+saveContext.swift
//  Rover
//
//  Created by Angel Avila on 5/22/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import CoreStore

extension HomeViewController {
    func saveContext(fetchedDogs: [DogViewModel]) {
        
        fetchedDogs.forEach { dog in
            saveDog(dog, cachedDogs: cachedDogs)
        }
        
        // Uncomment in case dogs would only be fetched from server, so they would be deleted if they aren't the updated version
        //deleteOldRecords(fetchedDogs: fetchedDogs, cachedDogs: cachedDogs)
        tableView.reloadData()
    }
    
    func fetchDogCache() {
        cachedDogs = items.objectsInAllSections().map { DogViewModel(fromDog: $0) }
        cachedDogs.forEach { print("Cached", $0.name) }
    }
    
    private func saveDog(_ dog: DogViewModel, cachedDogs: [DogViewModel] = [DogViewModel]()) {
        
        let dogIsFromCache = cachedDogs.filter { $0 == dog }.first != nil

        if dogIsFromCache {
            print(cachedDogs.filter { $0 == dog }.first!.name, "is from cache")
            return
        }
        
        stack.perform(asynchronous: { transaction in
            let created = transaction.create(Into<Dog>())

            created.name .= dog.name
            created.bio .= dog.bio
            
            if let image = dog.image, let data = image.pngData() {
                created.image .= data
            }
            
            created.owner .= dog.owner
            
            print("Saving:", created.name.value)
            
        }, completion: { _ in })
    }
    
    func deleteAll() {
        print("Deleting all...")
        _ = try? stack.perform(
            synchronous: { (transaction) in
                try transaction.deleteAll(From<Dog>())
            }
        )
    }
    
    private func deleteOldRecords(fetchedDogs: [DogViewModel], cachedDogs: [DogViewModel]) {

        var dict = Dictionary<String, DogViewModel>()
        
        fetchedDogs.forEach { dict[$0.name] = $0 }
        
        cachedDogs.forEach { cached in
            if dict[cached.name] == nil {
                print("Deleting", cached.name)
                deleteDog(cached)
            }
        }
    }
    
    func deleteDog(_ dog: DogViewModel)  {
        stack.perform(
            asynchronous: { (transaction) in
                let dogToDelete = try transaction.fetchOne(
                    From<Dog>()
                        .where(\.name == dog.name))

                transaction.delete(dogToDelete)
        },
            completion: { _ in }
        )
    }
}
