//
//  MyCollectionViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var teachers = [Teacher]()

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
        navigationItem.title = "我的关注"
        tableView.register(UINib(nibName: "TeacherHomeCell", bundle: nil), forCellReuseIdentifier: TeacherHomeCell.reuseIdentifier)
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

extension MyCollectionViewController: UITableViewDataSource {
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

extension MyCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teacher = teachers[indexPath.row]
        let controller = TeacherDetailViewController()
        controller.teacher = teacher
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
