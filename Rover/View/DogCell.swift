//
//  DogCell.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class DogCell: GenericTableViewCell<DogViewModel> {
    
    static var preferredHeight: CGFloat = 116
    
    override var item: DogViewModel? {
        didSet {
            guard let dog = item else { return }
            nameLabel.text = dog.name
            bioLabel.text = dog.bio
            dogImageView.image = dog.image
            setViewFrames()
        }
    }
    
    lazy var nameLabel = UILabel.withFont(font: UIFont.demiBold, size: 15, text: nil, textColor: .darkText, textAlignment: .left)
    
    lazy var bioLabel = UILabel.withFont(font: UIFont.regular, size: 14, text: nil, textColor: .lightText, textAlignment: .left)
    
    lazy var dogImageView: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentMode = .left
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(dogImageView)
    }
    
    fileprivate func setViewFrames() {
        dogImageView.pin.left(15)
            .top(15)
            .width(56)
            .height(56)
        
        nameLabel.pin.top(15)
            .right(of: dogImageView)
            .right(20)
            .height(16)
            .marginLeft(10)
        
        bioLabel.pin.top(to: nameLabel.edge.bottom)
            .right(of: dogImageView)
            .right(20)
            .bottom(15)
            .minHeight(66)
            .marginLeft(10)
            .marginTop(4)
    }
}
