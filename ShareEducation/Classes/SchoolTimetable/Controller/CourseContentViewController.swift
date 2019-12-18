//
//  CourseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class CourseContentViewController: BaseContentViewController {
    
    var playType: CoursePlayType = .living
    
    var calendarType: CalendarViewController.CalendarType = .month
    
    // MARK: - Property
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CourseSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: CourseSectionHeaderView.reuseIdentifier)
        tableView.register(CourseClassCell.self, forCellReuseIdentifier: CourseClassCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var monthHeaderView: MonthCalendarView = {
        let monthHeaderView = MonthCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 0))
        monthHeaderView.clipsToBounds = true
        monthHeaderView.heightChangeHandler = {
            self.tableView.tableHeaderView = monthHeaderView
        }
        return monthHeaderView
    }()
    
    lazy var weekHeaderView: WeekCalendarView = {
        let weeekHeaderView = WeekCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 0))
        weeekHeaderView.clipsToBounds = true
        return weeekHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func refreshCalendarUI() {
        if calendarType == .month {
            tableView.tableHeaderView = monthHeaderView
        } else {
            tableView.tableHeaderView = weekHeaderView
        }
    }
    
    func setupUI() {
        view.addSubview(tableView)
        refreshCalendarUI()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: - Actions
    @objc func onChangeCalendarTypeButtonPressed(_ sender: Any) {
        switch calendarType {
        case .month:
            calendarType = .week
        case .week:
            calendarType = .month
        }
        refreshCalendarUI()
        tableView.reloadData()
    }
}

extension CourseContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseClassCell.reuseIdentifier, for: indexPath) as! CourseClassCell
//        cell.course 
//        cell.setupData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CourseSectionHeaderView.reuseIdentifier) as! CourseSectionHeaderView
        headerView.courseCount = 12
        headerView.changeButton.addTarget(self, action: #selector(onChangeCalendarTypeButtonPressed(_:)), for: .touchUpInside)
        switch calendarType {
        case .month:
            headerView.changeButton.setTitle("本周课程", for: .normal)
        case .week:
            headerView.changeButton.setTitle("当月课程", for: .normal)
        }
        return headerView
    }
    
    
}

extension CourseContentViewController: UITableViewDelegate {
    
}
