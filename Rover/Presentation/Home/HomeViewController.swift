//
//  HomeViewController.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class HomeViewController: ListViewController<DogCell, Dog> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Dogs"
        fetchList()
    }
    
    @objc override func fetchList() {
        self.tableView.reloadData()
    }
}
