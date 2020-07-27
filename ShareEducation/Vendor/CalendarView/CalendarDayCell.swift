//
//  CalendarDayCell.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class CalendarDayCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.masksToBounds = true
        return label
    }()
    
    var dotView: UIView = {
        let dotView = UIView()
        dotView.backgroundColor = .red
        return dotView
    }()
    
    var date: Date! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        let day = date.day
        if date.isToday {
            titleLabel.backgroundColor = .clear
            titleLabel.layer.borderColor = UIColor.red.cgColor
            titleLabel.textColor = .red
            titleLabel.text = "今"
        } else {
            titleLabel.text = String(day)
            if isSelected {
                titleLabel.layer.borderColor = UIColor.red.cgColor
                titleLabel.backgroundColor = .red
                titleLabel.textColor = .white
            } else {
                titleLabel.backgroundColor = .clear
                titleLabel.layer.borderColor = UIColor.clear.cgColor
                titleLabel.textColor = .darkText
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.layer.cornerRadius = contentView.frame.width * 0.5
    }
    
    func commonInit() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dotView)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(contentView)
            make.height.equalTo(titleLabel.snp.width)
        }
        dotView.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(contentView)
            make.width.height.equalTo(5)
        }
    }
}
