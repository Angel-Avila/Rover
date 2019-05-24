//
//  DogDetailViewController.swift
//  Rover
//
//  Created by Angel Avila on 5/23/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class DogDetailViewController: ViewController<DogDetailView> {
    
    init(dog: DogViewModel) {
        super.init()
        controllerView = DogDetailView(dog: dog)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
