//
//  HomeContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import TYCyclePagerView
import SnapKit
import Then
import SwiftDate
import MJRefresh
import Jelly

class HomeContentViewController: BaseContentViewController {
    
    var animator: Animator?
    
    @IBOutlet var tableView: UITableView!
    
    override var course: Course {
        didSet {
            refreshData()
        }
    }
    
    lazy var pageControl = UIPageControl()
        
    lazy var pagerView: TYCyclePagerView = TYCyclePagerView().then { pagerView in
        let bannerCellWidth = UIScreen.main.bounds.width - 26
        let bannerCellHeight = bannerCellWidth * 140 / 349
        pagerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: bannerCellHeight + 25)
        pagerView.isInfiniteLoop = true
        pagerView.autoScrollInterval = 3.0
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(HomeBannerCell.classForCoder(), forCellWithReuseIdentifier: HomeBannerCell.reuseIdentifier)
        
        pagerView.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(pagerView)
            make.bottom.equalTo(pagerView).offset(-10)
        }
    }
    
    var courseList = [CourseItem]()
    
    var techerList = [Teacher]()
    
    lazy var teacherListCell: HomeTeacherTableCell = {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: HomeTeacherTableCell.reuseIdentifier, for: IndexPath(row: 0, section: 0)) as! HomeTeacherTableCell
        cell.didSelectTeacher = { teacher in
            let controller = TeacherDetailViewController()
            controller.teacher = teacher
            mainNavigationController.pushViewController(controller, animated: true)
        }
        return cell
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        refreshData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods
    
    override func gradeDidChange(_ notification: Notification) {
        refreshData()
    }
    
    override func areaDidChange(_ notification: Notification) {
        refreshData()
    }
    
    func setupUI() -> Void {
        tableView.register(HomeSetionTitleView.self, forHeaderFooterViewReuseIdentifier: HomeSetionTitleView.reuseIdentifier)
        tableView.register(HomeCourseCell.self, forCellReuseIdentifier: HomeCourseCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.mj_header = MJRefreshStateHeader{ self.refreshData() }
        tableView.mj_footer = MJRefreshAutoFooter{
            self.loadCourseData(offset: self.courseList.count)
        }
        reloadBannerUI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBannerUI), name: ShareData.shareDataDidUpdateNotification, object: nil)
    }
    
    @objc func reloadBannerUI() {
        let bannerResouces = ShareData.shared.bannerResources
        if let bannerResouces = bannerResouces {
            tableView.tableHeaderView = pagerView
            pagerView.reloadData()
            pageControl.numberOfPages = bannerResouces.count
        } else {
            tableView.tableHeaderView = nil
        }
    }
    
    func loadCourseData(offset: Int) {
        let grade = ShareSetting.shared.grade
        let area = ShareSetting.shared.area
        let user = User.shared
        
        let name = user.account
        let token = user.userInfo?.token
        
        serviceProvider.request(.getCourseList(type: .living, dateType: "3", date: Date().toFormat("yyyy-MM-dd"), name: name, token: token, offset: offset, rows: 20, areaid: area.id, courseid: course.id, gradeid: grade.id)) { (result) in
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
                            
            }
        }
    }
    
    private func refreshData() {
        let grade = ShareSetting.shared.grade
        let area = ShareSetting.shared.area
        
        serviceProvider.request(.getTeacherTopList(rows: 10, areaid: area.id, courseid: course.id, gradeid: grade.id)) { result in
            do {
                let response = try result.get().mapObject(ListResult<Teacher>.self)
                self.teacherListCell.teachers = response.data
                self.tableView.reloadData()
            } catch {
                            
            }
        }
        
        loadCourseData(offset: 0)
    }
}

extension HomeContentViewController: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    
    // MARK: TYCyclePagerViewDataSource
    
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        let bannerDatas = ShareData.shared.bannerResources
        return bannerDatas?.count ?? 0
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.reuseIdentifier, for: index) as! HomeBannerCell
        
        let resource = ShareData.shared.bannerResources![index]
        cell.imageView.kf.setImage(with: URL(string: resource.img.fullURLString))
        return cell
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        let resource = ShareData.shared.bannerResources![index]
        let urlString = resource.linkUrl
        let controller = WebViewController(url: urlString!)
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let bannerCellWidth = UIScreen.main.bounds.width - 26
        let bannerCellHeight = bannerCellWidth * 140 / 349
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: bannerCellWidth, height: bannerCellHeight)
        layout.itemSpacing = 7
        layout.itemVerticalCenter = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
//        self.pageControl.currentPage = toIndex;
        pageControl.currentPage = toIndex
    }
}

extension HomeContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if teacherListCell.teachers.count > 0 {
            count += 1
        }
        if courseList.count > 0 {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if teacherListCell.teachers.count > 0 && section == 0 {
            return 1
        } else {
            return courseList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if teacherListCell.teachers.count > 0 && indexPath.section == 0 {
            tableView.dequeueReusableCell(withIdentifier: HomeTeacherTableCell.reuseIdentifier)
            return teacherListCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCourseCell.reuseIdentifier, for: indexPath) as! HomeCourseCell
            
            let course = courseList[indexPath.row]
            cell.course = course
            cell.buyHandler = { course in
                
                let controller = CoursePlayViewController()
                controller.course = course
                mainNavigationController.pushViewController(controller, animated: true)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSetionTitleView.reuseIdentifier) as! HomeSetionTitleView
        if teacherListCell.teachers.count > 0 && section == 0 {
            sectionHeaderView.titleLabel.text = "明星老师"
        } else {
            sectionHeaderView.titleLabel.text = "推荐课程"
        }
        return sectionHeaderView
    }
}

extension HomeContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if teacherListCell.teachers.count > 0 && indexPath.section == 0 {
        } else {
            let course = courseList[indexPath.row]
            let controller = CourseDetailViewController()
            controller.course = course
            mainNavigationController.pushViewController(controller, animated: true)
        }
    }
}
