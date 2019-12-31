//
//  HomeClassCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/10.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class HomeCourseCell: CourseBaseCell {
    
    override func commonInit() {
        super.commonInit()
        timeImageView.isHidden = true
        backgroundImageView.image = UIImage(named: "bg_class")
        timeLabel.textColor = .black
        headImageView.layer.cornerRadius = 15
        headImageView.layer.masksToBounds = true
    }
    
    override func setupConstraints() {
        contentBgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(13)
            make.trailing.equalTo(contentView).offset(-13)
            make.bottom.equalTo(contentView).offset(-15)
            make.height.equalTo(150)
        }
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(-14 - onePixelWidth)
            make.leading.equalTo(contentBgView).offset(-13)
            make.trailing.equalTo(contentBgView).offset(13)
            make.bottom.equalTo(contentBgView).offset(14 + onePixelWidth)
        }
        
        courseBackgroundImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(11)
            make.top.equalTo(contentBgView).offset(15)
        }
        
        courseLabel.snp.makeConstraints { (make) in
            make.center.equalTo(courseBackgroundImageView)
        }
        
        classNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(courseBackgroundImageView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
            make.centerY.equalTo(courseBackgroundImageView)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(13)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
            make.top.equalTo(classNameLabel.snp.bottom).offset(15)
        }
        
        headImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(11)
            make.top.equalTo(timeLabel.snp.bottom).offset(15)
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
