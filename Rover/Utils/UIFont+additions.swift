//
//  UIFont+additions.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var regular: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    class var demiBold: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    class var medium: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    class var bold: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    
    
}
