//
//  MonthCalendarView.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class MonthCalendarView: UIView {
    
    // MARK: - Property
    
    let monthLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .textColor)
    
    lazy var previousButton = UIButton(image: UIImage(named: "icon_date_left"), target: self, selector: #selector(onPreviousButtonPressed(sender:)))
    
    lazy var nextButton = UIButton(image: UIImage(named: "icon_date_right"), target: self, selector: #selector(onNextButtonPressed(sender:)))
    
    lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(frame: CGRect(x: 13, y: 60, width: UIScreen.width - 26, height: 290))
        let style = CalendarView.Style()
        
        style.headerHeight = 33
        style.weekdaysHeight = 13
        style.weekdaysFont = .systemFont(ofSize: 14)
        style.weekdaysTextColor = .textColor
        style.weekdaysBottomMargin = 0
        style.headerBackgroundColor = .fff7e9
        style.weekdaysBackgroundColor = .fff7e9

        style.cellShape                = .round
        style.cellColorDefault         = UIColor.clear
        style.cellColorToday           = .clear
        
        style.cellTextColorDefault     = .textColor
        style.cellSelectedTextColor    = .white
        style.cellSelectedColor        = .e64919
        style.cellSelectedBorderColor  = .ff4d00
        style.cellSelectedBorderWidth  = 1
        style.cellTextColorToday       = .e64919
        style.cellBorderColorToday     = .e64919
        style.cellColorOutOfRange      = .textColor
            
        style.firstWeekday             = .monday
        
        style.locale                   = Locale(identifier: "zh_CN")
                
        style.cellFont = .systemFont(ofSize: 13)
        
        calendarView.style = style
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = false
        calendarView.enableDeslection = false
        
        calendarView.backgroundColor = .fff7e9
        calendarView.layer.cornerRadius = 10
        calendarView.layer.masksToBounds = true
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
            make.trailing.equalTo(self).offset(-13).priority(.low)
            make.height.equalTo(230)
        }
        
        let today = Date()
        calendarView.selectDate(today)
        calendarView.setDisplayDate(today)

    }
    
    // MARK: - Actions
    
    @objc func onPreviousButtonPressed(sender: AnyObject?) {
        
    }
    
    @objc func onNextButtonPressed(sender: AnyObject?) {
        
    }
    
}

extension MonthCalendarView: CalendarViewDataSource {
    // MARK : KDCalendarDataSource
      
    func startDate() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = -10
        
        let today = Date()
        
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 10
        let today = Date()
        let endDate = calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return endDate
    }
    
    func headerString(_ date: Date) -> String? {
        let month = calendarView.calendar.component(.month, from: date) // get month
        let year = calendarView.calendar.component(.year, from: date)
      
        let result = "\(year)年\(month)月"
        monthLabel.text = result
        return result
    }

}

extension MonthCalendarView: CalendarViewDelegate {
     // MARK : KDCalendarDelegate
    
     func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
         
         print("Did Select: \(date) with \(events.count) events")
         for event in events {
             print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
         }
         
     }
     
     func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
         
     }
     
     
     func calendar(_ calendar: CalendarView, didLongPressDate date : Date, withEvents events: [CalendarEvent]?) {
         
     }
}
