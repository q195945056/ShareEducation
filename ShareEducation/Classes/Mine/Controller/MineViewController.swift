//
//  MineViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/10/22.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit


class MineViewController: UIViewController {
    
    // MARK: - Property
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        return tableView
    }()
    
    lazy var tableHeaderView = MineTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: MineTableHeaderView.height))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private Methods
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.loginControl.addTarget(self, action: #selector(onLoginButtonPressed(_:)), for: .touchUpInside)
        tableHeaderView.settingButton.addTarget(self, action: #selector(onSettingButtonPressed(_:)), for: .touchUpInside)
        tableHeaderView.courseControl.addTarget(self, action: #selector(onMyCourseButtonPressed(_:)), for: .touchUpInside)
        tableHeaderView.collectionControl.addTarget(self, action: #selector(onMyCollectionButtonPressed(_:)), for: .touchUpInside)
        tableHeaderView.infoButton.addTarget(self, action: #selector(onUserInfoButtonPressed(_:)), for: .touchUpInside)
        tableHeaderView.inviteButton.addTarget(self, action: #selector(onInviteButtonPressed(_:)), for: .touchUpInside)
        tableView.register(UINib(nibName: "MineTableCell", bundle: nil), forCellReuseIdentifier: MineTableCell.reuseIdentifier)
        tableView.register(SeparatorLineFooterView.self, forHeaderFooterViewReuseIdentifier: SeparatorLineFooterView.reuseIdentifier)
    }
    
    // MARK: - Actions
    
    @objc func onLoginButtonPressed(_ sender: Any) {
        LoginViewController.show(from: self)
    }
    
    @objc func onSettingButtonPressed(_ sender: Any) {
        let controller = SettingViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    @objc func onMyCourseButtonPressed(_ sender: Any) {
        
    }
    
    @objc func onMyCollectionButtonPressed(_ sender: Any) {
        let controller = MyCollectionViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    @objc func onUserInfoButtonPressed(_ sender: Any) {
        let controller = EditUserinfoViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    @objc func onInviteButtonPressed(_ sender: Any) {
        
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

extension MineViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTableCell.reuseIdentifier, for: indexPath) as! MineTableCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.iconImageView.image = UIImage(named: "icon_my01")
                cell.titleLabel.text = "优惠券"
                cell.descLabel.isHidden = true
            } else if indexPath.row == 1 {
                cell.iconImageView.image = UIImage(named: "icon_my02")
                cell.titleLabel.text = "最新活动"
                cell.descLabel.isHidden = true
            }
        } else {
            if indexPath.row == 0 {
                cell.iconImageView.image = UIImage(named: "icon_my03")
                cell.titleLabel.text = "消息中心"
                cell.descLabel.isHidden = true
            } else if indexPath.row == 1 {
                cell.iconImageView.image = UIImage(named: "icon_my04")
                cell.titleLabel.text = "我的客服"
                cell.descLabel.isHidden = false
            } else {
                cell.iconImageView.image = UIImage(named: "icon_my05")
                cell.titleLabel.text = "意见反馈"
                cell.descLabel.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return onePixelWidth
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SeparatorLineFooterView.reuseIdentifier) as! SeparatorLineFooterView
            return footerView
        } else {
            return nil
        }
    }
}

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                enterCouponListPage()
            } else if indexPath.row == 1 {
                enterActivityListPage()
            }
        } else {
            if indexPath.row == 0 {
                enterMessageListPage()
            } else if indexPath.row == 1 {
                enterCustomServicePage()
            } else {
                enterFeedbackPage()
            }
        }
    }
}

extension MineViewController {
    func enterCouponListPage() {
        let controller = CouponListViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    func enterActivityListPage() {
        let controller = ActivityListViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    func enterMessageListPage() {
        let controller = MessageListViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    func enterCustomServicePage() {
        let controller = CustomerServiceViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
    
    func enterFeedbackPage() {
        let controller = FeedbackViewController()
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
