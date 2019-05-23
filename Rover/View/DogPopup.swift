//
//  DogPopup.swift
//  Rover
//
//  Created by Angel Avila on 5/23/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout
import MaterialComponents

class DogPopup: MDCCard {
    
    lazy var imageView: UIImageView! = {
        let iv = UIImageView(image: nil)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var dogNameLabel = UILabel.withFont(font: UIFont.demiBold, size: 17, text: nil, textColor: .darkText, textAlignment: .left)
    lazy var dogBioLabel = UILabel.withFont(font: UIFont.regular, size: 15, text: nil, textColor: .lightText, textAlignment: .left)
    
    init() {
        super.init(frame: .zero)
        
        cornerRadius = 15
        inkView.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        inkView.addSubview(imageView)
        inkView.addSubview(dogNameLabel)
        inkView.addSubview(dogBioLabel)
        
        imageView.pin.top()
            .horizontally()
            .height(72%)
        
        dogNameLabel.pin.below(of: imageView)
            .horizontally(6)
            .height(19)
            .marginTop(8)
        
        dogBioLabel.pin.below(of: dogNameLabel)
            .horizontally(6)
            .bottom(6)
            .minHeight(45)
            .marginTop(8)
        
        dogBioLabel.sizeToFit()
    }
}
