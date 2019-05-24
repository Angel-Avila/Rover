//
//  UIViewController+setupNavBar.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

extension UIViewController {
    func setupNavBar(title: String) {
        self.title = title
        let navigationBar = self.navigationController?.navigationBar
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if #available(iOS 11.0, *) {
            navigationBar?.prefersLargeTitles = false
        }
        navigationBar?.tintColor = .white
        navigationBar?.barTintColor = .roverGreen
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        navigationBar?.layer.shadowColor = UIColor.black.cgColor
        navigationBar?.layer.shadowOffset = CGSize(width: 0, height: 1)
        navigationBar?.layer.masksToBounds = false
    }
    
    func topBarHeight() -> CGFloat {
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + navBarHeight
        
        return topBarHeight
    }
    
    func pinControllerViewToTopBar(_ controllerView: UIView) {
        view.addSubview(controllerView)
        controllerView.pin.top(view.pin.safeArea)
            .bottom()
            .horizontally()
    }
}

