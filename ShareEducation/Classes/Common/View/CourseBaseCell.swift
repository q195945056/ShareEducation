//
//  ClassBaseCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/17.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

class CourseBaseCell: UITableViewCell {
    lazy var timeImageView = UIImageView(image: UIImage(named: "icon_clock"))
    lazy var timeLabel = UILabel(font: .systemFont(ofSize: 13), textColor: .e64919)
    lazy var courseBackgroundImageView = UIImageView(image: UIImage(named: "tag_class"))
    lazy var courseLabel = UILabel(font: .systemFont(ofSize: 9), textColor: .fefefe)
    lazy var classNameLabel = UILabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .darkTextColor)
    lazy var headImageView = UIImageView()
    lazy var teacherInfoLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .normalTextColor)
    lazy var countLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .lightTextColor)
    lazy var subscribeButton = UIButton(backgroundImage: UIImage(named: "button01"), title: "立即预约", target: self, selector: #selector(onSubscribeButtonPressed(sender:))).then {
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    lazy var contentBgView = UIView()
    lazy var backgroundImageView = UIImageView()
    
    var course: CourseItem? {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    // MARK: - Private Methods
    
    func updateUI() {
        if let course = course {
            courseLabel.text = course.course
            let startTime = course.startTime?.toFormat("MM月dd日 EE HH:mm", locale: Locales.chinese)
            let endTime = course.endTime?.toFormat("HH:mm")
            if let startTime = startTime, let endTime = endTime {
                timeLabel.text = "\(startTime)-\(endTime)"
            }
            classNameLabel.text = course.name
            if let name = course.trueName, let schoolName = course.schoolName {
                teacherInfoLabel.text = "\(name)  \(schoolName)"
            } else {
                teacherInfoLabel.text = nil
            }
            headImageView.kf.setImage(with: URL(string: course.pic ?? ""))
            countLabel.text = String(course.buyCount ?? 0) + "人已预约"
        }
    }
    
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(backgroundImageView)
        contentBgView.addSubview(timeImageView)
        contentBgView.addSubview(courseBackgroundImageView)
        contentBgView.addSubview(courseLabel)
        contentBgView.addSubview(classNameLabel)
        contentBgView.addSubview(timeLabel)
        contentBgView.addSubview(headImageView)
        contentBgView.addSubview(teacherInfoLabel)
        contentBgView.addSubview(countLabel)
        contentBgView.addSubview(subscribeButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
    }
    
    func setupData() {
        courseLabel.text = "物理"
        classNameLabel.text = "【秋】初一大科学直播创新班（全国版）"
        timeLabel.text = "10月7日 周六 08:30-09:30"
        teacherInfoLabel.text = "何小英  特级教师  北京大学附属一小"
        countLabel.text = "2095人已预约"
        subscribeButton.setTitle("立即预约", for: .normal)
    }
    
    // MARK: - Actions
    
    @objc func onSubscribeButtonPressed(sender: AnyObject) {
        
    }
}
