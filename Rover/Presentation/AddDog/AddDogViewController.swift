//
//  AddDogViewController.swift
//  Rover
//
//  Created by Angel Avila on 5/23/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreServices

enum TargetObservable {
    case void
    case dog(value: DogViewModel)
}

protocol Responder {
    func getResponse() -> Observable<TargetObservable>
}

class AddDogViewController: ViewController<AddDogView> {
    
    private var imagePicker = UIImagePickerController()
    let response = PublishSubject<TargetObservable>()
    
    init() {
        super.init(showsNavBar: true, title: "New Dog")
        controllerView = AddDogView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
        setupImagePicker()
        
        _ = controllerView.addImageButton.rx.tap.bind {
            self.addImagePressed()
        }
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    fileprivate func setupBarButtons() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonPressed() {
        let dog = DogViewModel(name: controllerView.dogNameTextField.text ?? "", owner: controllerView.dogOwnerTextField.text ?? "", bio: controllerView.dogBioTextField.text ?? "", image: controllerView.dogImageView.image)
        response.onNext(TargetObservable.dog(value: dog))
        navigationController?.popViewController(animated: true)
    }
}

extension AddDogViewController {
    private func imageAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Choose a photo", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        return alert
    }
    
    private func addImagePressed() {
        let alert = imageAlert()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = controllerView
            alert.popoverPresentationController?.sourceRect = controllerView.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension AddDogViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = Dictionary(uniqueKeysWithValues: info.map {key, value in (key.rawValue, value)})
        
        if let editedPhoto = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            saveImage(editedPhoto, picker: picker)
        } else if let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            saveImage(selectedPhoto, picker: picker)
        }
    }
    
    private func saveImage(_ image: UIImage, picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        controllerView.dogImageView.image = image
        controllerView.imageBackground.alpha = 0.36
    }
}

extension AddDogViewController: UINavigationControllerDelegate {
    
}

extension AddDogViewController: Responder {
    func getResponse() -> Observable<TargetObservable> {
        return response.asObservable()
    }
}
