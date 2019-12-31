//
//  CourseUnitViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseUnitViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var units = [CourseUnit]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        tableView.register(UINib(nibName: "CourseDetailUnitCell", bundle: nil), forCellReuseIdentifier: CourseDetailUnitCell.reuseIdentifier)
        navigationItem.title = "单元课程"
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

extension CourseUnitViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailUnitCell.reuseIdentifier, for: indexPath) as! CourseDetailUnitCell
        let unit = units[indexPath.row]
        cell.unit = unit
        cell.rankingLabel.text = String(indexPath.row + 1)
        return cell
    }
    
}

extension CourseDetailViewController: UITableViewDelegate {
    
}
