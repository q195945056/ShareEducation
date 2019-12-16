//
//  MonthCalendarView.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class MonthCalendarView: UIView {
    
    // MARK: - Property
    
    let monthLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkTextColor)
    
    lazy var previousButton = UIButton(image: UIImage(named: "icon_date_left"), target: self, selector: #selector(onPreviousButtonPressed(sender:)))
    
    lazy var nextButton = UIButton(image: UIImage(named: "icon_date_right"), target: self, selector: #selector(onNextButtonPressed(sender:)))
    
    lazy var calendarView: CalendarView = {
        let calendarView = CalendarView()
        calendarView.delegate = self
        return calendarView
    }()
    
    var heightChangeHandler: (() -> Void)?

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
        monthLabel.text = "2019年10月"
        addSubview(monthLabel)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(calendarView)
        
        monthLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(13)
            make.top.equalTo(self).offset(21)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-13)
            make.bottom.equalTo(monthLabel)
        }
        
        previousButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(nextButton.snp.leading).offset(-20)
            make.bottom.equalTo(nextButton)
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(60)
            make.leading.equalTo(self).offset(13)
            make.trailing.equalTo(self).offset(-13).priority(.high)
        }        
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 60 + calendarView.height)
    }
    
    // MARK: - Actions
    
    @objc func onPreviousButtonPressed(sender: AnyObject?) {
//        calendarView.goToPreviousMonth()
    }
    
    @objc func onNextButtonPressed(sender: AnyObject?) {
    }
    
}

extension MonthCalendarView: CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, heightWillChangeTo height: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 60 + calendarView.height)
        if let heightChangeHandler = heightChangeHandler {
            heightChangeHandler()
        }
    }
}



