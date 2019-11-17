//
//  GradeCollectionCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/13.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class GradeCollectionCell: UICollectionViewCell {
    lazy var titleLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13)
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
    
    private func commonInit() {
        contentView.backgroundColor = .f5f5f5

        layer.cornerRadius = 14
        layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .fcece8
                titleLabel.textColor = .red
            } else {
                contentView.backgroundColor = .f5f5f5
                titleLabel.textColor = .darkTextColor
            }
        }
    }
}
