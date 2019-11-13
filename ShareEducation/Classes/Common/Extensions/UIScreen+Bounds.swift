//
//  UIScreen+Bounds.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/13.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension UIScreen {
    static var width: Double {
        return Double(main.bounds.width)
    }
    
    static var height: Double {
        return Double(main.bounds.height)
    }
}

