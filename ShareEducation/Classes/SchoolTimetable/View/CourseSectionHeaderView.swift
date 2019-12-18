//
//  CourseSectionHeaderView.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/17.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class CourseSectionHeaderView: UITableViewHeaderFooterView {
    lazy var courseCountLable = UILabel(font: .systemFont(ofSize: 13), textColor: .darkTextColor)
    lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("本周课程", for: .normal)
        button.setTitleColor(UIColor(red: 231, green: 73, blue: 24), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        return button
    }()
    
    lazy var indicatorImageView = UIImageView(image: UIImage(named: "icon_more_home"))
    
    var courseCount = 12 {
        didSet {
            let string = "当天共 \(courseCount) 节课"
            let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.darkTextColor])
            let range = string.range(of: "\(courseCount)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.e64919, range: NSRange(range!, in: string))
            courseCountLable.attributedText = attributedString
        }
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        contentView.addSubview(courseCountLable)
        contentView.addSubview(changeButton)
        contentView.addSubview(indicatorImageView)
        
        courseCountLable.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(13)
            make.centerY.equalTo(contentView)
        }
        
        indicatorImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView).offset(-13)
            make.centerY.equalTo(courseCountLable)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(indicatorImageView.snp.leading).offset(-8)
            make.centerY.equalTo(courseCountLable)
        }
        

    }
}
