//
//  UIColor+theme.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIColor {
    // init uicolor from hex
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UIColor {
    static var roverGreen = UIColor(hex: "77C045")
    static var roverDarkGreen = UIColor(hex: "4E822A")
    static var darkText = UIColor(hex: "555555")
    static var lightText = UIColor(hex: "989898")
    static var placeholderText = UIColor(hex: "777777")
    static var divider = UIColor(hex: "DFDFDF")
}
