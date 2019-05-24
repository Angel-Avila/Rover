//
//  AddDogView.swift
//  Rover
//
//  Created by Angel Avila on 5/23/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout
import MaterialComponents

class AddDogView: ControllerView {
    
    lazy var dogImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var imageBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkText
        return view
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "iconAdd"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    lazy var dogNameTextField: MDCTextField = {
        let textField = MDCTextField(frame: .zero)
        textField.placeholder = "Dog Name"
        textField.backgroundColor = .white
        textField.font = UIFont.regular.withSize(17)
        return textField
    }()
    var dogNameController: MDCTextInputControllerBase!
    
    lazy var dogOwnerTextField: MDCTextField = {
        let textField = MDCTextField(frame: .zero)
        textField.placeholder = "Owner"
        textField.backgroundColor = .white
        textField.font = UIFont.regular.withSize(17)
        return textField
    }()
    var dogOwnerController: MDCTextInputControllerBase!
    
    lazy var dogBioTextField: MDCMultilineTextField = {
        let textField = MDCMultilineTextField()
        textField.placeholder = "Add a brief dog bio"
        textField.backgroundColor = .white
        textField.font = UIFont.regular.withSize(17)
        return textField
    }()
    var dogBioController: MDCTextInputControllerBase!
    
    override init() {
        super.init()
        
        dogNameController = MDCTextInputControllerFilled(textInput: dogNameTextField)
        
        dogOwnerController = MDCTextInputControllerFilled(textInput: dogOwnerTextField)
        
        dogBioController = MDCTextInputControllerOutlinedTextArea(textInput: dogBioTextField)
        
        [dogNameController, dogOwnerController, dogBioController].forEach { controller in
            controller?.borderFillColor = .clear
            controller?.floatingPlaceholderActiveColor = .roverDarkGreen
            controller?.activeColor = .roverDarkGreen
            controller?.textInputFont = UIFont.regular.withSize(17)
        }

        dogBioController.underlineHeightActive = 0
        dogBioController.underlineHeightNormal = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        addSubview(dogImageView)
        addSubview(imageBackground)
        addSubview(addImageButton)
        addSubview(dogNameTextField)
        addSubview(dogOwnerTextField)
        addSubview(dogBioTextField)
        
        [dogImageView, imageBackground, addImageButton].forEach { view in
            view.pin.horizontally()
                .top()
                .aspectRatio(16/9)
        }
        
        dogNameTextField.pin.below(of: addImageButton)
            .horizontally()
            .height(65)
        
        dogOwnerTextField.pin.below(of: dogNameTextField)
            .horizontally()
            .height(65)
        
        dogBioTextField.pin.below(of: dogOwnerTextField)
            .horizontally(8)
            .bottom(pin.safeArea)
            .marginTop(20)
    }
}
