//
//  HomeViewController.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import CoreStore
import CoreData

class HomeViewController: UITableViewController {
    
    let presenter: HomePresenter!
    
    var cachedDogs = [DogViewModel]()
    
    var stack: DataStack!
    var items: ListMonitor<Dog>!
    let cellId = "id"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Init & deinit
    
    deinit {
        items.removeObserver(self)
    }
    
    init(withPresenter presenter: HomePresenter) {
        self.presenter = presenter
        
        super.init(style: .plain)
        initStack()
        fetchDogCache()
        downloadDogs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initStack() {
        stack = DataStack(
            CoreStoreSchema(
                modelVersion: "1",
                entities: [Entity<Dog>("Dog")],
                versionLock: [
                    "Dog": [0xe425af568b6df780, 0x832135ba64e43659, 0xddf6233ec1cecfc3, 0x22c9d887a2b7f77e]
                    ])
        )
        
        try! stack.addStorageAndWait(
            SQLiteStore(
                fileName: "DogData.sqlite",
                localStorageOptions: .none))
        
        items = stack.monitorList(From<Dog>().orderBy(.ascending(\.name)))
        
        items.addObserver(self)
    }
    
    private func downloadDogs() {
        _ = presenter.fetchDogs().subscribe(onNext: { dogs in
            self.saveContext(fetchedDogs: dogs)
        }, onError: { error in
            print(error)
        })
    }
    
    // MARK: View funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Dogs"
        
        tableView.register(DogCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        
        tableView.pin.all(view.pin.safeArea)
    }
    
    // MARK: TableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.numberOfObjects()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! DogCell
        
        cell.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: cell.frame.size.height)
        cell.contentView.frame = cell.frame
        let dog = items[indexPath]
        cell.item = dog.asDogViewViewModel()
        
        return cell
    }
    
    // MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DogCell.preferredHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case .delete:
            let dog = items[indexPath]
            
            stack.perform(
                asynchronous: { (transaction) in
                    
                    transaction.delete(dog)
            },
                completion: { _ in }
            )
            
        default:
            break
        }
    }
}

// MARK: ListObserver

extension HomeViewController: ListObserver {
    func listMonitorWillChange(_ monitor: ListMonitor<Dog>) {
        self.tableView.beginUpdates()
    }
    
    func listMonitorDidChange(_ monitor: ListMonitor<Dog>) {
        self.tableView.endUpdates()
    }
    
    func listMonitorWillRefetch(_ monitor: ListMonitor<Dog>) {
        
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Dog>) {
        self.tableView.reloadData()
    }
    
}

// MARK: ListObjectObserver

extension HomeViewController: ListObjectObserver {
    func listMonitor(_ monitor: ListMonitor<Dog>, didInsertObject object: Dog, toIndexPath indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func listMonitor(_ monitor: ListMonitor<Dog>, didDeleteObject object: Dog, fromIndexPath indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func listMonitor(_ monitor: ListMonitor<Dog>, didUpdateObject object: Dog, atIndexPath indexPath: IndexPath) {
        
        if let cell = self.tableView.cellForRow(at: indexPath) as? DogCell {
            
            let dog = items[indexPath]
            cell.item = dog.asDogViewViewModel()
        }
    }
    
    func listMonitor(_ monitor: ListMonitor<Dog>, didMoveObject object: Dog, fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        self.tableView.deleteRows(at: [fromIndexPath], with: .automatic)
        self.tableView.insertRows(at: [toIndexPath], with: .automatic)
    }
}
