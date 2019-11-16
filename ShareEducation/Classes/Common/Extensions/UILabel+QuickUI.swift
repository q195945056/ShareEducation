//
//  UILabel+QuickUI.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont?, textColor: UIColor?) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}
