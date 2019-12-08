//
//  EditUserinfoViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Kingfisher

class EditUserinfoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var titles: [String] = ["头像", "用户昵称", "真实姓名", "性别", "身份证号", "学籍号", "地区", "所在学校", "年级", "联系邮箱", "手机号码"]
    
    var values: [String] = ["https://www.baidu.com", "NANA", "张庆", "女", "14754778844145598", "110133131443113223", "四川省 成都市", "成都泡桐树小学", "二年级", "1475748@qq.com", "14787454778"]

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
        navigationItem.title = "个人资料"
        tableView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: UserInfoCell.reuseIdentifier)
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

extension EditUserinfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentifier, for: indexPath) as! UserInfoCell
        
        let title = titles[indexPath.row]
        cell.titleLabel.text = title
        
        let value = values[indexPath.row]
        if indexPath.row == 0 {
            cell.headImageView.isHidden = false
            cell.descriptionLabel.isHidden = true
            cell.headImageView.kf.setImage(with: URL(string: value))
        } else {
            cell.headImageView.isHidden = true
            cell.descriptionLabel.isHidden = false
            cell.descriptionLabel.text = value
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        } else {
            return 50
        }
    }
    
}

extension EditUserinfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
            
        } else {
            
        }
    }

}
