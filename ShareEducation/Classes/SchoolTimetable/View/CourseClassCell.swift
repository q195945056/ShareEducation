//
//  CourseTableCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/17.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class CourseClassCell: CourseBaseCell {
    
    override func commonInit() {
        super.commonInit()
        backgroundImageView.image = UIImage(named: "bg_class2")
        headImageView.layer.cornerRadius = 15
        headImageView.layer.masksToBounds = true
    }
    
    override func setupConstraints() {
        contentBgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(contentView).offset(13)
            make.trailing.equalTo(contentView).offset(-13)
            make.bottom.equalTo(contentView)
            make.height.equalTo(150)
        }
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(-14 - onePixelWidth)
            make.leading.equalTo(contentBgView).offset(-13)
            make.trailing.equalTo(contentBgView).offset(13)
            make.bottom.equalTo(contentBgView).offset(14 + onePixelWidth)
        }
        
        timeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(5 + onePixelWidth)
            make.leading.equalTo(contentBgView).offset(12)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(timeImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
            make.centerY.equalTo(timeImageView)
        }
        
        courseBackgroundImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(11)
            make.top.equalTo(contentBgView).offset(40)
        }
        
        courseLabel.snp.makeConstraints { (make) in
            make.center.equalTo(courseBackgroundImageView)
        }
        
        classNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(courseBackgroundImageView.snp.trailing).offset(7)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
            make.centerY.equalTo(courseBackgroundImageView)
        }
        
        headImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(11)
            make.top.equalTo(classNameLabel.snp.bottom).offset(15)
            make.width.height.equalTo(30)
        }
        
        teacherInfoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headImageView.snp.trailing).offset(11)
            make.centerY.equalTo(headImageView)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(13)
            make.top.equalTo(headImageView.snp.bottom).offset(15)
        }
        
        subscribeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(countLabel)
            make.trailing.equalTo(contentBgView).offset(-11)
            make.width.equalTo(79)
            make.height.equalTo(28)
        }
    }
}
