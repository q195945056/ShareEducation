//
//  PaymentCourseCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class PaymentCourseCell: CourseBaseCell {

    lazy var priceLabel = UILabel(font: .systemFont(ofSize: 15, weight: .heavy), textColor: .darkTextColor)
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .f3f3f3
        return line
    }()

    override func commonInit() {
        backgroundColor = .clear
        contentBgView.addSubview(priceLabel)
        contentBgView.addSubview(bottomLine)
        super.commonInit()
        timeLabel.textColor = .lightTextColor
        contentBgView.backgroundColor = .white
        classNameLabel.numberOfLines = 0
        backgroundImageView.removeFromSuperview()
        timeImageView.removeFromSuperview()
        headImageView.removeFromSuperview()
        courseBackgroundImageView.removeFromSuperview()
        courseLabel.removeFromSuperview()
        countLabel.removeFromSuperview()
        subscribeButton.removeFromSuperview()
    }
    
    override func setupConstraints() {
        contentBgView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        classNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(23)
            make.leading.equalTo(contentBgView).offset(14)
            make.trailing.equalTo(contentBgView).offset(-93)
            make.bottom.equalTo(contentBgView).offset(-73)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(15)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-15)
            make.top.equalTo(classNameLabel.snp.bottom).offset(15)
        }
        
        teacherInfoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(15)
            make.top.equalTo(classNameLabel.snp.bottom).offset(15)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-15)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentBgView).offset(-14)
            make.top.equalTo(contentBgView).offset(24 + onePixelWidth)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.equalTo(contentBgView).offset(13)
            make.bottom.trailing.equalTo(contentBgView)
            make.height.equalTo(onePixelWidth)
        }
    }
    
    override func updateUI() {
        super.updateUI()
        
        teacherInfoLabel.text = course?.trueName
        priceLabel.text = String(course?.price ?? 0)
        
        #if DEBUG
        classNameLabel.text = "【秋（下）】初一数学直播勤学班（全国北师）"
        timeLabel.text = "10月07日-12月28日 每周六 18:20-20:30"
        headImageView.backgroundColor = .red
        teacherInfoLabel.text = "丽琴"
        priceLabel.text = "799"
        #endif
    }

}
