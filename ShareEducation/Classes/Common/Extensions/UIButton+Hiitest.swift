//
//  UIButton+Hiitest.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension UIButton {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds = self.bounds
        let widthDelta = max(44 - bounds.width, 0)
        let heightDelta = max(44 - bounds.height, 0)
        bounds = bounds.insetBy(dx: -widthDelta * 0.5, dy: -heightDelta * 0.5)
        return bounds.contains(point)
    }
}
