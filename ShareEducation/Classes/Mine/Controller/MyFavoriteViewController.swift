//
//  MyFavoriteViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/2.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit
import Moya
import MJRefresh

class MyFavoriteViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var teachers = [Teacher]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        refreshData()
    }

    func setupUI() {
        tableView.register(UINib(nibName: "TeacherHomeCell", bundle: nil), forCellReuseIdentifier: TeacherHomeCell.reuseIdentifier)
        tableView.mj_header = MJRefreshHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
    }
    
    @objc func refreshData() {
        loadDatas { result in
            let response = try? result.get().mapObject(ListResult<Teacher>.self)
            if let response = response {
                self.teachers = response.data
                self.tableView.reloadData()
                if self.tableView.mj_header!.isRefreshing {
                    self.tableView.mj_header!.endRefreshing()
                }
            }
        }
    }
    
    func loadDatas(completion: @escaping Moya.Completion) {
        serviceProvider.request(.teacherMyCollect, completion: completion)
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

extension MyFavoriteViewController: UITableViewDataSource {
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

extension MyFavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teacher = teachers[indexPath.row]
        let controller = TeacherDetailViewController()
        controller.teacher = teacher
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
