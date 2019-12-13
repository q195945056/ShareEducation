//
//  TeacherDetailViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class TeacherDetailViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TeacherDetailInfoCell", bundle: nil), forCellReuseIdentifier: TeacherDetailInfoCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TeacherDetailSegmentedCell", bundle: nil), forCellReuseIdentifier: TeacherDetailSegmentedCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TeacherDetailCommentCell", bundle: nil), forCellReuseIdentifier: TeacherDetailCommentCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TeacherDetailDescriptionCell", bundle: nil), forCellReuseIdentifier: TeacherDetailDescriptionCell.reuseIdentifier)

        tableView.register(HomeCourseCell.self, forCellReuseIdentifier: HomeCourseCell.reuseIdentifier)
        return tableView
    }()
    
    var courses: [CourseItem]? {
        didSet {
            if segmentCell.segmentedControl.selectedSegmentIndex == 0 {
                tableView.reloadData()
            }
        }
    }
    
    var comments: [Comment]? {
        didSet {
            if segmentCell.segmentedControl.selectedSegmentIndex == 2 {
                tableView.reloadData()
            }
        }
    }
    
    
    var teacher: Teacher! {
        didSet {
            self.infoCell.teacher = teacher
        }
    }
    
    lazy var infoCell: TeacherDetailInfoCell = {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeacherDetailInfoCell.reuseIdentifier) as! TeacherDetailInfoCell
        return cell
    }()
    
    lazy var segmentCell: TeacherDetailSegmentedCell = {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeacherDetailSegmentedCell.reuseIdentifier) as! TeacherDetailSegmentedCell
        cell.segmentedControl.addTarget(self, action: #selector(onSegmentedValueChanged(sender:)), for: .valueChanged)
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func loadData() {
        serviceProvider.request(.getTeacherDetail(name: nil, token: nil, id: teacher.mid)) { (result) in
            let json = try? JSON(data: result.get().data)
            if let json = json {
                let data = json["data"]
                self.teacher.setup(extraData: data)
                self.infoCell.teacher = self.teacher
                
                let mapper = Mapper<CourseItem>()
                let courses = mapper.mapArray(JSONObject: json["data1"].arrayObject)
                courses?.forEach({ course in
                    course.teacherName = self.teacher.truename
                    course.schoolName = self.teacher.schoolname
                    course.pic = self.teacher.pic
                })
                self.courses = courses;
            }

        }
    }

    // MARK: - Actions
    
    @objc func onSegmentedValueChanged(sender: YLSegmentedControl) {
        tableView.reloadData()
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

extension TeacherDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 2 {
            return 1
        } else {
            let selectedSegmentIndex = segmentCell.segmentedControl.selectedSegmentIndex
            if selectedSegmentIndex == 0 {
                return courses?.count ?? 0
            } else if selectedSegmentIndex == 1 {
                return 3
            } else {
                return comments?.count ?? 10
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.dequeueReusableCell(withIdentifier: TeacherDetailInfoCell.reuseIdentifier)
            return self.infoCell
        } else if indexPath.section == 1 {
            tableView.dequeueReusableCell(withIdentifier: TeacherDetailSegmentedCell.reuseIdentifier)
            return self.segmentCell
        } else {
            let selectedSegmentIndex = segmentCell.segmentedControl.selectedSegmentIndex

            if selectedSegmentIndex == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeCourseCell.reuseIdentifier, for: indexPath) as! HomeCourseCell
                let course = courses![indexPath.row]
                cell.course = course
                return cell
            } else if selectedSegmentIndex == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TeacherDetailDescriptionCell.reuseIdentifier, for: indexPath) as! TeacherDetailDescriptionCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TeacherDetailCommentCell.reuseIdentifier, for: indexPath) as! TeacherDetailCommentCell
//                let comment = comments![indexPath.row]
                return cell
            }
        }
    }
}

extension TeacherDetailViewController: UITableViewDelegate {
    
}
