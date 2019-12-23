//
//  CourseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import SwiftDate
import MJRefresh
import Jelly

class CourseContentViewController: BaseContentViewController {
    
    var animator: Animator?
    
    var playType: CoursePlayType = .living
    
    var calendarType: CalendarViewController.CalendarType = .month
    
    var courseList = [CourseItem]()
    
    
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
        monthHeaderView.didChangeToMonth = { month in
            self.refreshData()
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
        refreshData()
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
        tableView.mj_header = MJRefreshStateHeader { self.refreshData() }
        tableView.mj_footer = MJRefreshAutoFooter { self.loadMoreData() }
    }
    
    // MARK: - Private
    
    private func refreshData() {
        loadCourseData(offset: 0)
    }
    
    private func loadMoreData() {
        loadCourseData(offset: courseList.count)
    }
    
    func loadCourseData(offset: Int) {
        let grade = ShareSetting.shared.grade
        let area = ShareSetting.shared.area
        let user = User.shared
        
        let name = user.name
        let token = user.token
        
        var dateType: String = ""
        var dateString: String = ""
        if calendarType == .month {
            dateType = "1"
            dateString = monthHeaderView.month.toFormat("yyyy-MM")
        } else if calendarType == .week {
            dateType = "2"
            dateString = Date().toFormat("yyyy-MM-dd")
        }
        
        serviceProvider.request(.getCourseList(type: playType, dateType: dateType, date: dateString, name: name, token: token, offset: offset, rows: 20, areaid: area.id, courseid: course.id, gradeid: grade.id)) { (result) in
            do {
                let response = try result.get().mapObject(ListResult<CourseItem>.self)
                if offset == 0 {
                    self.courseList = response.data
                } else {
                    self.courseList.append(contentsOf: response.data)
                }
                self.tableView.reloadData()
                if self.tableView.mj_header!.isRefreshing {
                    self.tableView.mj_header?.endRefreshing()
                }
                if self.courseList.count >= response.total! {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer?.resetNoMoreData()
                }
            } catch {
                print(error)
            }
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
        return courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseClassCell.reuseIdentifier, for: indexPath) as! CourseClassCell
        let course = courseList[indexPath.row]
        cell.course = course
        cell.buyHandler = { course in
            let controller = CourseSbscribeAlertViewController()
            controller.course = course
            controller.confirmHandler = {
                let vc = SelectCourseViewController()
                vc.course = course
                mainNavigationController.pushViewController(vc, animated: true)
            }
            let size = PresentationSize(width: .fullscreen, height: .custom(value: 365))
            let marginGuards = UIEdgeInsets(top: 0, left: 47 + onePixelWidth, bottom: 0, right: 47 + onePixelWidth)
            let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.8))
            let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
            let animator = Animator(presentation: presentation)
            animator.prepare(presentedViewController: controller)
            self.animator = animator
            mainNavigationController.present(controller, animated: true)
        }
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
