//
//  CustomNavigationBar.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {
    
    // MARK: - Property
    let gradeLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .textColor
        label.text = "年级"
    }
    
    lazy var gradeButton: UIControl = {
        let control = UIControl()
        let imageView = UIImageView(image: UIImage(named: "icon_grade"))
        control.addSubview(gradeLabel)
        control.addSubview(imageView)
        gradeLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(control)
        }
        imageView.snp.makeConstraints { (make) in
            make.leading.equalTo(gradeLabel.snp.trailing).offset(5)
            make.trailing.equalTo(control)
            make.centerY.equalTo(control)
        }
        return control
    }()
    
    lazy var searchButton: UIControl = {
        let control = UIControl()
        let imageView = UIImageView(image: UIImage(named: "icon_search"))
        control.addSubview(imageView)
        let label = UILabel()
        label.text = "搜索老师/课程/学科/学校"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .a6aeb9
        control.addSubview(label)
        imageView.snp.makeConstraints { (make) in
            make.leading.equalTo(control).offset(9)
            make.centerY.equalTo(control)
        }
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(control).offset(25)
            make.centerY.equalTo(control)
        }
        control.layer.cornerRadius = 15
        control.layer.masksToBounds = true
        control.backgroundColor = .f7f7f7
        return control
    }()
    
    let historyButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_history"), for: .normal)
    }
    
    let locationButton = UIButton().then{
        $0.setImage(UIImage(named: "icon_map"), for: .normal)
    }
        
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        addSubview(gradeButton)
        addSubview(searchButton)
        addSubview(historyButton)
        addSubview(locationButton)
        
        gradeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(13)
            make.centerY.equalTo(self)
        }
        searchButton.snp.makeConstraints { (make) in
            make.leading.equalTo(gradeButton.snp.trailing).offset(13)
            make.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        historyButton.snp.makeConstraints { (make) in
            make.leading.equalTo(searchButton.snp.trailing).offset(16)
            make.centerY.equalTo(self)
        }
        locationButton.snp.makeConstraints { (make) in
            make.leading.equalTo(historyButton.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-13)
            make.centerY.equalTo(self)
        }
    }
    
}
