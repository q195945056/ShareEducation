//
//  HomeBannerCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import SnapKit

class HomeBannerCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let result = UIImageView()
        result.layer.cornerRadius = 15
        result.layer.masksToBounds = true
        return result
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    func _commonInit() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(contentView)
        }
    }
}
