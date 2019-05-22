//
//  ViewController.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

class ViewController<V: View>: UIViewController {
    
    var controllerView: V!
    
    private var showsNavBar: Bool!
    private var didAddView = false
    private var savedTitle = ""
    
    init(showsNavBar: Bool = false, title: String = "") {
        super.init(nibName: nil, bundle: nil)
        self.showsNavBar = showsNavBar
        savedTitle = title
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if !showsNavBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            view.addSubview(controllerView)
            controllerView.pin.all()
            controllerView.setupUI()
        }
        
        if title == "" {
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = savedTitle
        
        if showsNavBar && !didAddView {
            self.setupNavBar(title: self.title ?? "")
            pinControllerViewToTopBar(controllerView)
            controllerView.setupUI()
            didAddView = true
        }
        
        if !showsNavBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}
