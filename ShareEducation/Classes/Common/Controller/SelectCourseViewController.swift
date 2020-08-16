//
//  SelectCourseViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SelectCourseViewController: UIViewController {
    
    var course: CourseItem!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var selectIndicatorImageView: UIImageView!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var bottomView: UIView!
    
    var courses = [CourseItem]()
    
    var totalPrice: Int = 0

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
        navigationItem.title = "选课单"
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowColor = UIColor.d5d5d5.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
        tableView.register(CourseSelectCell.self, forCellReuseIdentifier: CourseSelectCell.reuseIdentifier)
    }
    
    func loadData() {
        
        User.buyCourse(course: course) { (result) in
            switch result {
            case let .success(datas):
                self.courses = datas
                self.tableView.reloadData()
                self.selectDefaultCourse()
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
    }
    
    func selectDefaultCourse() {
        var index = -1
        for i in 0..<courses.count {
            let c = courses[i]
            if c == course {
                index = i
                break
            }
        }
        if index >= 0 {
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            tableView(tableView, didSelectRowAt: indexPath)
        }
    }
    
    @IBAction func onPayButtonPressed(_ sender: Any) {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            var selectedCourses = [CourseItem]()
            for path in selectedIndexPaths {
                let course = courses[path.row]
                selectedCourses.append(course)
            }
            let controller = PaymentViewController()
            controller.totalPrice = totalPrice
            controller.selectedCourses = selectedCourses
            navigationController?.pushViewController(controller, animated: true)
        }
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

extension SelectCourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseSelectCell.reuseIdentifier, for: indexPath) as! CourseSelectCell
        let course = courses[indexPath.row]
        cell.course = course
        return cell
    }
}

extension SelectCourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            var total: Int = 0
            for path in selectedIndexPaths {
                let course = courses[path.row]
                total += course.price ?? 0
            }
            totalPrice = total
            totalPriceLabel.text = String(format: "￥%.2f", Float(total) / 100)
        }
    }
}
