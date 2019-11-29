//
//  SelectCourseViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SelectCourseViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var selectIndicatorImageView: UIImageView!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var bottomView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        navigationItem.title = "选课单"
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowColor = UIColor.d5d5d5.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
        tableView.register(CourseSelectCell.self, forCellReuseIdentifier: CourseSelectCell.reuseIdentifier)
        
    }
    
    
    @IBAction func onPayButtonPressed(_ sender: Any) {
        let controller = PaymentViewController()
        navigationController?.pushViewController(controller, animated: true)
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

extension SelectCourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseSelectCell.reuseIdentifier, for: indexPath) as! CourseSelectCell
        cell.course = nil
        return cell
    }
    
    
}

extension SelectCourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
