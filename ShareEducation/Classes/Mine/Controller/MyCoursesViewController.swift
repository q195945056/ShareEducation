//
//  MyCoursesViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/8/2.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit
import MJRefresh
import Moya

class MyCoursesViewController: UIViewController {
    var courseList = [CourseItem]()

    @IBOutlet var sortSegmentedControl: YLSegmentedControl!
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        navigationItem.title = "我的课程"
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 4))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        tableView.register(UINib(nibName: "MyCourseListCell", bundle: nil), forCellReuseIdentifier: MyCourseListCell.reuseIdentifier)
        tableView.mj_header = MJRefreshStateHeader{ self.refreshData() }
        sortSegmentedControl.items = ["全部", "年级", "学科"]
        sortSegmentedControl.aligment = .center
        sortSegmentedControl.widthOption = .custom(value: 40)
        sortSegmentedControl.contentInset = UIEdgeInsets(top: 0, left: 47, bottom: 0, right: 47)
        sortSegmentedControl.showIndicator = true
        sortSegmentedControl.rightIndicatorImage = R.image.icon_paixu3()
    }
    
    func refreshData() {
        loadDatas { result in
            let response = try? result.get().mapObject(ListResult<Teacher>.self)
            if let response = response {
                self.tableView.reloadData()
                if self.tableView.mj_header!.isRefreshing {
                    self.tableView.mj_header!.endRefreshing()
                }
            }
        }
    }
    
    func loadDatas(completion: @escaping Moya.Completion) {
        serviceProvider.request(.courseMyList, completion: completion)
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

extension MyCoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCourseListCell.reuseIdentifier, for: indexPath) as! MyCourseListCell
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

extension MyCoursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courseList[indexPath.row]
        let controller = CourseDetailViewController()
        controller.course = course
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
