//
//  TeacherContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/1.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import MJRefresh
import Moya

class TeacherContentViewController: BaseContentViewController {
    
    override var course: Course {
        didSet {
            refreshData()
        }
    }
    
    @IBOutlet var sortSegmentedControl: YLSegmentedControl!
    
    @IBOutlet var tableView: UITableView!
    
    var teachers = [Teacher]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        refreshData()
    }

    func setupUI() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 4))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        tableView.register(UINib(nibName: "TeacherHomeCell", bundle: nil), forCellReuseIdentifier: TeacherHomeCell.reuseIdentifier)
        tableView.mj_header = MJRefreshStateHeader{
            self.refreshData()
        }
        tableView.mj_footer = MJRefreshAutoFooter{ self.loadMore() }
        sortSegmentedControl.items = ["综合", "评分", "播放"]
        sortSegmentedControl.aligment = .center
        sortSegmentedControl.widthOption = .custom(value: 40)
        sortSegmentedControl.contentInset = UIEdgeInsets(top: 0, left: 47, bottom: 0, right: 47)
        sortSegmentedControl.showIndicator = true
        sortSegmentedControl.rightIndicatorImage = R.image.icon_paixu3()
    }
    
    func refreshData() {
        loadDatas(offset: 0) { result in
            let response = try? result.get().mapObject(ListResult<Teacher>.self)
            if let response = response {
                self.teachers = response.data
                self.tableView.reloadData()
                if self.teachers.count >= response.total! {
                    self.tableView.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer!.resetNoMoreData()
                }
            } else {
                if self.tableView.mj_footer!.isRefreshing {
                    self.tableView.mj_footer?.endRefreshing()
                }
            }
            
            if self.tableView.mj_header!.isRefreshing {
                self.tableView.mj_header!.endRefreshing()
            }
        }
    }
    
    func loadMore() {
        loadDatas(offset: teachers.count) { result in
            let response = try? result.get().mapObject(ListResult<Teacher>.self)
            if let response = response {
                self.teachers.append(contentsOf: response.data)
                self.tableView.reloadData()
                if self.teachers.count >= response.total! {
                    self.tableView.mj_footer!.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer!.resetNoMoreData()
                }
            }
        }
    }
    
    func loadDatas(offset: Int, completion: @escaping Moya.Completion) {
        let grade = ShareSetting.shared.grade
        let area = ShareSetting.shared.area
        serviceProvider.request(.getTeacherList(offset: offset, rows: 20, areaid: area.id, courseid: course.id, gradeid: grade.id, sort: sortSegmentedControl.selectedSegmentIndex), completion: completion)
    }
    
    // MARK: - Actions
    
    @IBAction func onSortSegmentedValueChanged(_ sender: YLSegmentedControl) {
        refreshData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeacherContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeacherHomeCell.reuseIdentifier, for: indexPath) as! TeacherHomeCell
        let teacher = teachers[indexPath.row]
        cell.teacher = teacher
        return cell
    }
    
    
}

extension TeacherContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teacher = teachers[indexPath.row]
        let controller = TeacherDetailViewController()
        controller.teacher = teacher
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
