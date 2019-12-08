//
//  SettingViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var footerView: UIView!

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
        navigationItem.title = "设置"
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.register(SeparatorLineFooterView.self, forHeaderFooterViewReuseIdentifier: SeparatorLineFooterView.reuseIdentifier)
        
        if User.shared.isLogin {
            tableView.tableFooterView = footerView
        }
    }
    
    // MARK: - Actions
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        User.shared.logout()
        tableView.tableFooterView = nil
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

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
        if indexPath.section == 0 {
            cell.titleLabel.text = "账户与安全"
            cell.descriptionLabel.isHidden = true
            cell.switch.isHidden = true
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.titleLabel.text = "消息通知"
                cell.descriptionLabel.isHidden = true
                cell.switch.isHidden = false
            } else if indexPath.row == 1 {
                cell.titleLabel.text = "仅在Wi-Fi下播放视频"
                cell.descriptionLabel.isHidden = true
                cell.switch.isHidden = false
            } else {
                cell.titleLabel.text = "清除缓存"
                cell.descriptionLabel.text = "14.MB"
                cell.descriptionLabel.isHidden = false
                cell.switch.isHidden = true
            }
        } else {
            cell.titleLabel.text = "关于名师来啦"
            cell.descriptionLabel.isHidden = true
            cell.switch.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SeparatorLineFooterView.reuseIdentifier) as! SeparatorLineFooterView
        return footerView
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            enterAccountSafePage()
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                
            } else if indexPath.row == 1 {
                
            } else {
                
            }
        } else {
            enterAboutPage()
        }
    }
    
    func enterAccountSafePage() {
        let controller = AccountSafeViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func enterAboutPage() {
        let controller = AboutViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
