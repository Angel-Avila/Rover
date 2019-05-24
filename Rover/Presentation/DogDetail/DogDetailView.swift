//
//  DogDetailView.swift
//  Rover
//
//  Created by Angel Avila on 5/23/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

class DogDetailView: ControllerView {
    
    lazy var popupView = DogPopup()
    
    init(dog: DogViewModel) {
        super.init()
        popupView.dogNameLabel.text = dog.name
        popupView.dogBioLabel.text = dog.bio
        popupView.imageView.image = dog.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        backgroundColor = .clear
        addSubview(popupView)
        
        popupView.pin.width(80%)
            .height(57%)
            .center()
        
        popupView.setupUI()
    }
}
