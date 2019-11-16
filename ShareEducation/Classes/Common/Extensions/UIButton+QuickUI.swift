//
//  UIButton+QuickUI.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(type: UIButton.ButtonType = .custom, image: UIImage? = nil, title: String? = nil, target: Any? = nil, selector: Selector? = nil) {
        self.init(type: type)
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
        if let selector = selector {
            addTarget(target, action: selector, for: .touchUpInside)
        }
    }
}



