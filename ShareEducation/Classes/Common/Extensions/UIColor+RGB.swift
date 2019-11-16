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
    static let e64919 = #colorLiteral(red: 0.9019607843, green: 0.2862745098, blue: 0.09803921569, alpha: 1)
    static let f5f5f5 = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    static let f7f7f7 = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    static let fcece8 = #colorLiteral(red: 0.9882352941, green: 0.9254901961, blue: 0.9098039216, alpha: 1)
    static let a6aeb9 = #colorLiteral(red: 0.6509803922, green: 0.6823529412, blue: 0.7254901961, alpha: 1)
}
