//
//  CourseDetailViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly

class CourseDetailViewController: UIViewController {
    
    // MARK: - Property
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var collectButton: UIButton!
    
    @IBOutlet var buyButton: UIButton!
    
    var animator: Animator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Private Methods
    
    fileprivate func setupUI() {
        navigationItem.title = "课程介绍"
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowColor = UIColor.d5d5d5.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
        tableView.register(UINib(nibName: "CourseDetailCoverCell", bundle: nil), forCellReuseIdentifier: CourseDetailCoverCell.reuseIdentifier)
        tableView.register(UINib(nibName: "CourseDetailDescptionCell", bundle: nil), forCellReuseIdentifier: CourseDetailDescptionCell.reuseIdentifier)
        tableView.register(UINib(nibName: "CourseDetailTeacherCell", bundle: nil), forCellReuseIdentifier: CourseDetailTeacherCell.reuseIdentifier)
        tableView.register(UINib(nibName: "CourseDetailUnitCell", bundle: nil), forCellReuseIdentifier: CourseDetailUnitCell.reuseIdentifier)
        tableView.register(UINib(nibName: "CourseDetailUnitDescriptionCell", bundle: nil), forCellReuseIdentifier: CourseDetailUnitDescriptionCell.reuseIdentifier)
        tableView.register(CourseUnitTitleView.self, forHeaderFooterViewReuseIdentifier: CourseUnitTitleView.reuseIdentifier)
        tableView.register(CourseUnitFooterView.self, forHeaderFooterViewReuseIdentifier: CourseUnitFooterView.reuseIdentifier)
    }
    
    // MARK: - Actions
    
    @objc func onBuyButtonPressed(sender: Any) {
        let controller = CourseSbscribeAlertViewController()
        controller.confirmHandler = {
            let vc = SelectCourseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 365))
        let marginGuards = UIEdgeInsets(top: 0, left: 47 + onePixelWidth, bottom: 0, right: 47 + onePixelWidth)
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        present(controller, animated: true)
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

extension CourseDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailCoverCell.reuseIdentifier, for: indexPath) as! CourseDetailCoverCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailDescptionCell.reuseIdentifier, for: indexPath) as! CourseDetailDescptionCell
            cell.buyButton.addTarget(self, action: #selector(onBuyButtonPressed(sender:)), for: .touchUpInside)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailTeacherCell.reuseIdentifier, for: indexPath) as! CourseDetailTeacherCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailUnitCell.reuseIdentifier, for: indexPath) as! CourseDetailUnitCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseDetailUnitDescriptionCell.reuseIdentifier, for: indexPath) as! CourseDetailUnitDescriptionCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 35
        } else {
            return onePixelWidth
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CourseUnitTitleView.reuseIdentifier)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var result: CGFloat = 8
        if section == 3 {
            result += CourseUnitFooterView.height
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CourseUnitFooterView.reuseIdentifier)
            return footerView
        } else {
            return nil
        }
    }
}

extension CourseDetailViewController: UITableViewDelegate {
    
}
