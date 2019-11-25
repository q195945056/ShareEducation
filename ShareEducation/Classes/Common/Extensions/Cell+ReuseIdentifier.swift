//
//  Cell+ReuseIdentifier.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/10.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionReusableView: ReusableView {}

extension ReusableView  {
    static var reuseIdentifier: String {
        String(describing: self)
    }    
}




