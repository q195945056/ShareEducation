//
//  CourseSelectCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseSelectCell: CourseBaseCell {
    
    lazy var selectIndicatorImageView = UIImageView(image: UIImage(named: "icon_sel2"))
    
    lazy var priceLabel = UILabel(font: .systemFont(ofSize: 18, weight: .heavy), textColor: .e64919)
    
    lazy var unitLabel = UILabel(font: .systemFont(ofSize: 12, weight: .heavy), textColor: .e64919).then {
        $0.text = "￥"
    }

    override func commonInit() {
        backgroundColor = .clear
        contentBgView.addSubview(selectIndicatorImageView)
        contentBgView.addSubview(priceLabel)
        contentBgView.addSubview(unitLabel)
        super.commonInit()
        timeLabel.textColor = .lightTextColor
        contentBgView.backgroundColor = .white
        classNameLabel.numberOfLines = 0
        backgroundImageView.removeFromSuperview()
        timeImageView.removeFromSuperview()
        courseBackgroundImageView.removeFromSuperview()
        courseLabel.removeFromSuperview()
        countLabel.removeFromSuperview()
        subscribeButton.removeFromSuperview()

    }
    
    override func setupConstraints() {
        contentBgView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-8)
        }
        
        classNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(25)
            make.leading.equalTo(contentBgView).offset(48)
            make.trailing.equalTo(contentBgView).offset(-31)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(46)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-14)
            make.top.equalTo(classNameLabel.snp.bottom).offset(14)
        }
        
        headImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(48 + onePixelWidth)
            make.top.equalTo(timeLabel.snp.bottom).offset(18)
            make.width.height.equalTo(27)
            make.bottom.equalTo(contentBgView).offset(-25)
        }
        
        teacherInfoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headImageView.snp.trailing).offset(11)
            make.centerY.equalTo(headImageView)
            make.trailing.lessThanOrEqualTo(contentBgView).offset(-13)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentBgView).offset(-13 - onePixelWidth)
            make.bottom.equalTo(contentBgView).offset(-31)
        }
        
        unitLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(priceLabel)
            make.trailing.equalTo(priceLabel.snp.leading)
        }
        
        selectIndicatorImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentBgView).offset(13)
            make.bottom.equalTo(contentBgView).offset(-55)
        }

    }
    
    override func updateUI() {
        super.updateUI()
        
        teacherInfoLabel.text = course?.teacherName
        priceLabel.text = String(course?.price ?? 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectIndicatorImageView.image = UIImage(named: "icon_sel")
        } else {
            selectIndicatorImageView.image = UIImage(named: "icon_sel2")
        }
    }

}
