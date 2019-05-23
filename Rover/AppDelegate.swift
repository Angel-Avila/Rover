//
//  AppDelegate.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let provider = DogServices()
        let presenter = HomePresenterImpl(withProvider: provider)
        let home = HomeViewController(withPresenter: presenter)
        let root = UINavigationController(rootViewController: home)
        
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        overrideAppearance()
        
        return true
    }
    
    fileprivate func overrideAppearance() {
        UINavigationBar.appearance().layer.borderWidth = 0
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .roverGreen
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().layer.borderWidth = 0
        UITabBar.appearance().clipsToBounds = true
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
