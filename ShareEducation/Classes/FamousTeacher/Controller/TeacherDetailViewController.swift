//
//  TeacherDetailViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TeacherDetailInfoCell", bundle: nil), forCellReuseIdentifier: TeacherDetailInfoCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TeacherDetailSegmentedCell", bundle: nil), forCellReuseIdentifier: TeacherDetailSegmentedCell.reuseIdentifier)
        return tableView
    }()
    
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

    // MARK: - Actions
    
    @objc func onSegmentedValueChanged(sender: YLSegmentedControl) {
         
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.dequeueReusableCell(withIdentifier: TeacherDetailInfoCell.reuseIdentifier)
            return self.infoCell
        } else if indexPath.section == 1 {
            tableView.dequeueReusableCell(withIdentifier: TeacherDetailSegmentedCell.reuseIdentifier)
            return self.segmentCell
        }
        return UITableViewCell()
    }
}

extension TeacherDetailViewController: UITableViewDelegate {
    
}
