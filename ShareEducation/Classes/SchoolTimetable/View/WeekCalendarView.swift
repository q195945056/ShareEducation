//
//  WeekCalendarView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class WeekCalendarView: UIView {

    // MARK: - Property
    
    let titleLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkTextColor)
    
    lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(frame: .zero, type: .week)
        return calendarView
    }()
    

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private
    
    func commonInit() {
        titleLabel.text = "本周课程"
        addSubview(titleLabel)
        addSubview(calendarView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(13)
            make.top.equalTo(self).offset(21)
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(60)
            make.leading.equalTo(self).offset(13)
            make.trailing.equalTo(self).offset(-13).priority(.high)
        }
        calendarView.backgroundColor = .fff7e9
        calendarView.layer.cornerRadius = 10
        calendarView.layer.masksToBounds = true
        
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 60 + calendarView.height)
    }
}
