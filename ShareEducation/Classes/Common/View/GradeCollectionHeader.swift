//
//  GradeCollectionHeader.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class GradeCollectionHeader: UICollectionReusableView {
    let titleLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .darkTextColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(19)
            make.centerY.equalTo(self)
        }
    }
}
