//
//  PaymentViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftyJSON

class PaymentViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var payButton: UIButton!
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    var selectedCourses: [CourseItem]!
    
    var totalPrice: Float = 0
    
    var couponNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        navigationItem.title = "付款"
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowColor = UIColor.d5d5d5.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
        tableView.register(PaymentCourseCell.self, forCellReuseIdentifier: PaymentCourseCell.reuseIdentifier)
        tableView.register(UINib(nibName: "PaymentCouponCell", bundle: nil), forCellReuseIdentifier: PaymentCouponCell.reuseIdentifier)
        tableView.register(UINib(nibName: "PaymentPriceDetailCell", bundle: nil), forCellReuseIdentifier: PaymentPriceDetailCell.reuseIdentifier)
        tableView.register(UINib(nibName: "PaymentPayTypeCell", bundle: nil), forCellReuseIdentifier: PaymentPayTypeCell.reuseIdentifier)
        tableView.register(PaymentSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: PaymentSectionHeaderView.reuseIdentifier)
        
        countLabel.text = "共\(selectedCourses.count)项，实付款："
        
        totalPriceLabel.text = String(format: "￥%.2f", totalPrice)
        
        tableView.selectRow(at: IndexPath(row: 0, section: 3), animated: false, scrollPosition: .none)
    }
    
    @IBAction func onPayButtonPressed(_ sender: Any) {
        let indexPath = tableView.indexPathForSelectedRow ?? IndexPath(row: 0, section: 3)
        let type = PaymentType(rawValue: indexPath.row)!
        print(type)
        
        var ids = ""
        for i in 0..<selectedCourses.count {
            let course = selectedCourses[i]
            ids.append(String(course.id))
            if i != selectedCourses.count - 1 {
                ids.append(",")
            }
        }
        
        var payType: Int = 2
        var terminal: Int = 2
        
        if type == .wechat {
            payType = 2
            terminal = 2
        } else if type == .alipay {
            payType = 1
            terminal = 2
        } else if type == .patriarch {
            terminal = 1
            payType = 0
        }
        
        User.courseOrder(ids: ids, terminal: terminal, payType: payType) { (result) in
            switch result {
            case let .success(response):
                if type == .wechat {
                    self.payWechat(response)
                } else if type == .alipay {
                    self.payAli(response)
                } else if type == .patriarch {
                    self.payQrCode(response)
                }
                print(response)
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
    }
    
    func payQrCode(_ json: JSON) {
        let data = json["data"]
        let price = data["price"].intValue
        let code_url = data["code_url"].stringValue
        let orderID = data["orderid"].stringValue
        QrCodePayViewController.show(in: self, price: price, urlString: code_url, orderID: orderID) {
            let controller = PayResultViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func payAli(_ json: JSON) {

        PaymentManager.default.payAli(json) { (result) in
            switch result {
            case .success:
                let controller = PayResultViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            case let .failure(error):
                switch error {
                case .userCanceled:
                    break
                default:
                    Utilities.toast(error.errorDescription)
                }
            }
        }
    }
    
    func payWechat(_ json: JSON) {
        PaymentManager.default.payWechat(json) { (result) in
            switch result {
            case .success:
                let controller = PayResultViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            case let .failure(error):
                switch error {
                case .userCanceled:
                    break
                default:
                    Utilities.toast(error.errorDescription)
                }
            }
        }
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

extension PaymentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return selectedCourses.count
        case 1, 2:
            return 1
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCourseCell.reuseIdentifier, for: indexPath) as! PaymentCourseCell
            let course = selectedCourses[indexPath.row]
            cell.course = course
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCouponCell.reuseIdentifier, for: indexPath) as! PaymentCouponCell
            cell.couponNumber = 0
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentPriceDetailCell.reuseIdentifier, for: indexPath) as! PaymentPriceDetailCell
            cell.totalPrice = totalPrice
            cell.couponNumber = 0
            cell.updateUI()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentPayTypeCell.reuseIdentifier, for: indexPath) as! PaymentPayTypeCell
            let type = PaymentType(rawValue: indexPath.row)!
            cell.iconImageView.image = type.icon
            cell.titleLabel.text = type.title
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 3 {
            return 35
        } else {
            return onePixelWidth
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PaymentSectionHeaderView.reuseIdentifier) as! PaymentSectionHeaderView
            if section == 0 {
                headerView.titleLabel.text = "课程信息"
            } else {
                headerView.titleLabel.text = "付款方式"
            }
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
}

extension PaymentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 3 {
            return indexPath
        } else {
            return nil
        }
    }
}
