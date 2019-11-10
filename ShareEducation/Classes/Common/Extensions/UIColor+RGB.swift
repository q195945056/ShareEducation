//
//  UIColor+RGB.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

extension UIColor {
       
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    
}
