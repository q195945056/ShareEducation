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

class HomeContentViewController: BaseContentViewController {
    
    @IBOutlet var tableView: UITableView!
        
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
        
        _setupUI()
        refreshData()
    }
    

    
    // MARK: - Private Methods
    
    func _setupUI() -> Void {
        tableView.register(HomeSetionTitleView.self, forHeaderFooterViewReuseIdentifier: HomeSetionTitleView.reuseIdentifier)
        tableView.register(HomeCourseCell.self, forCellReuseIdentifier: HomeCourseCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        reloadBannerUI()
    }
    
    func reloadBannerUI() {
        let bannerResouces = ShareData.shared.bannerResources
        if let _ = bannerResouces {
            tableView.tableHeaderView = pagerView
            pagerView.reloadData()
        } else {
            tableView.tableHeaderView = nil
        }
    }
    
    private func refreshData() {
        let grade = ShareSetting.shared.grade
        serviceProvider.request(.getTeacherTopList(name: nil, token: nil, rows: "10", areaid: "0", courseid: String(course.id), gradeid: String(grade.id))) { result in
            do {
                let response = try result.get().mapObject(ListResult<Teacher>.self)
                self.teacherListCell.teachers = response.data
            } catch {
                            
            }
        }
        
        
        serviceProvider.request(.getCourseList(type: "1", dateType: "3", date: Date().toFormat("yyyy-MM-dd"), name: nil, token: nil, offset: "0", rows: "20", areaid: "0", courseid: "0", gradeid: "0")) { (result) in
            do {
                let response = try result.get().mapObject(ListResult<CourseItem>.self)
                self.courseList.append(contentsOf: response.data)
                self.tableView.reloadData()
                print(response)
            } catch {
                            
            }
        }
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return HomeTeacherTableCell.cellHeight
//        } else {
//            return HomeTeacherTableCell.cellHeight
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
