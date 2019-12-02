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
        
    lazy var pagerView: TYCyclePagerView = TYCyclePagerView().then { pagerView in
        let bannerCellWidth = UIScreen.main.bounds.width - 26
        let bannerCellHeight = bannerCellWidth * 140 / 349
        pagerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: bannerCellHeight + 25)
        pagerView.isInfiniteLoop = true
        pagerView.autoScrollInterval = 3.0
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(HomeBannerCell.classForCoder(), forCellWithReuseIdentifier: HomeBannerCell.reuseIdentifier)
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
        refreshData()
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
        if let _ = bannerResouces {
            tableView.tableHeaderView = pagerView
            pagerView.reloadData()
        } else {
            tableView.tableHeaderView = nil
        }
    }
    
    func loadCourseData(offset: Int) {
        let grade = ShareSetting.shared.grade
        let area = ShareSetting.shared.area
        let user = User.shared
        
        let name = String(user.userInfo?.id ?? 0)
        let token = user.userInfo?.token
        let areaID: String = String(area.id)
        let courseID: String = String(course.id)
        let gradeID: String = String(grade.id)
        
        let offsetString = String(offset)
        serviceProvider.request(.getCourseList(type: "1", dateType: "3", date: Date().toFormat("yyyy-MM-dd"), name: name, token: token, offset: offsetString, rows: "20", areaid: areaID, courseid: courseID, gradeid: gradeID)) { (result) in
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
        let user = User.shared
        
        let name: String? = nil
        let token = user.userInfo?.token
        let areaID: String = String(area.id)
        let courseID: String = String(course.id)
        let gradeID: String = String(grade.id)
        
        serviceProvider.request(.getTeacherTopList(name: name, token: token, rows: "10", areaid: areaID, courseid: courseID, gradeid: gradeID)) { result in
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
    }
}

extension HomeContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return courseList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.dequeueReusableCell(withIdentifier: HomeTeacherTableCell.reuseIdentifier)
            return teacherListCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCourseCell.reuseIdentifier, for: indexPath) as! HomeCourseCell
            
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
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSetionTitleView.reuseIdentifier) as! HomeSetionTitleView
        sectionHeaderView.titleLabel.text = "明星老师"
        return sectionHeaderView
    }
}

extension HomeContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let course = courseList[indexPath.row]
            let controller = CourseDetailViewController()
            mainNavigationController.pushViewController(controller, animated: true)
        }
    }
}
