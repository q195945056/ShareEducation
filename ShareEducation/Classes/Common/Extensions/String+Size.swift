//
//  String+Size.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/25.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension String {
    func size(font: UIFont) -> CGSize {
        let nsString = NSString(string: self)
        return nsString.size(font: font)
    }
}

extension NSString {
    func size(font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font : font]
        let size = self.size(withAttributes: attributes)
        let result = CGSize(width: size.width.ylCeil, height: size.height.ylCeil)
        return result
    }
}
