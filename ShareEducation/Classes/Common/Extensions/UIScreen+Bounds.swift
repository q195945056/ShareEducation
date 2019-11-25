//
//  UIScreen+Bounds.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/13.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

let actualStatusBarHeight = UIApplication.shared.statusBarFrame.height

extension UIScreen {
    static var width: Double {
        return Double(main.bounds.width)
    }
    
    static var height: Double {
        return Double(main.bounds.height)
    }
}

