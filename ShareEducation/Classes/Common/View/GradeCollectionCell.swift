//
//  GradeCollectionCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/13.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class GradeCollectionCell: UICollectionViewCell {
    lazy var titleLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13)
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
        layer.cornerRadius = 17.5
        layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemPink
                titleLabel.textColor = .red
            } else {
                backgroundColor = UIColor(red: 253, green: 253, blue: 253)
                titleLabel.textColor = UIColor(red: 51, green: 51, blue: 51)
            }
        }
    }
}
