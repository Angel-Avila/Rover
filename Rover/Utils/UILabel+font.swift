//
//  UILabel+font.swift
//  Rover
//
//  Created by Angel Avila on 5/21/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UILabel {
    static func withFont(font: UIFont, size: CGFloat? = nil, text: String? = nil, textColor: UIColor = .darkGray, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        
        if let size = size {
            label.font = font.withSize(size)
        } else {
            label.font = font
        }
        
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        
        return label
    }
}
