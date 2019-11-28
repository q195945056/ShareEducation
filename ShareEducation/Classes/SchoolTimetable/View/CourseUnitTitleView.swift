//
//  CourseUnitTitleView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseUnitTitleView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static var height: CGFloat = 35
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        let label = UILabel(font: .systemFont(ofSize: 17, weight: .heavy), textColor: .darkTextColor)
        label.text = "单元课程"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(14)
            make.top.equalTo(contentView).offset(13 + onePixelWidth)
        }
    }

}
