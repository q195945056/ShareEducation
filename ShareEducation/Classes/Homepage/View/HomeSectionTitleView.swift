//
//  HomeSectionTitleView.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SnapKit

class HomeSetionTitleView: UITableViewHeaderFooterView {
        
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 51, green: 51, blue: 51)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        return titleLabel
    }()
    
    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        _commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _commonInit()
    }
    
    func _commonInit() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicatorImageView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(13)
            make.centerY.equalTo(contentView)
        }
        
        indicatorImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView).offset(-13)
            make.centerY.equalTo(titleLabel)
        }
    }
    
}
