//
//  SettingViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class AccountSafeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        navigationItem.title = "设置"
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: SettingCell.reuseIdentifier)

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

extension AccountSafeViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "修改手机号码"
            cell.descriptionLabel.text = "14785471245"
            cell.descriptionLabel.isHidden = false
            cell.switch.isHidden = true
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "修改密码"
            cell.descriptionLabel.isHidden = true
            cell.switch.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 20
    }
    
}

extension AccountSafeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let controller = EditPhoneViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 1 {
            let controller = FindPwdViewController()
            controller.type = .modify
            navigationController?.pushViewController(controller, animated: true)
        } else {
            
        }
    }

}
