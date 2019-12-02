//
//  TeacherContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/1.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherContentViewController: BaseContentViewController {
    
    @IBOutlet var sortSegmentedControl: YLSegmentedControl!
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        tableView.register(UINib(nibName: "TeacherHomeCell", bundle: nil), forCellReuseIdentifier: TeacherHomeCell.reuseIdentifier)
        sortSegmentedControl.items = ["综合", "评分", "播放"]
        sortSegmentedControl.aligment = .center
        sortSegmentedControl.widthOption = .custom(value: 40)
        sortSegmentedControl.contentInset = UIEdgeInsets(top: 0, left: 47, bottom: 0, right: 47)
        sortSegmentedControl.showIndicator = true
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeacherHomeCell.reuseIdentifier, for: indexPath) as! TeacherHomeCell
        return cell
    }
    
    
}

extension TeacherContentViewController: UITableViewDelegate {
    
}
