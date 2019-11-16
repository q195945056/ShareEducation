//
//  CourseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseContentViewController: BaseContentViewController {
    
    // MARK: - Property
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let monthHeaderView = MonthCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 290))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.tableHeaderView = monthHeaderView
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

extension CourseContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension CourseContentViewController: UITableViewDelegate {
    
}
