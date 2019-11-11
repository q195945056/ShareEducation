//
//  Cell+ReuseIdentifier.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/10.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }    
}
