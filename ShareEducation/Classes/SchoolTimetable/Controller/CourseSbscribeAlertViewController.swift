//
//  CourseSbscribeAlertViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class CourseSbscribeAlertViewController: UIViewController {
    
    var course: CourseItem!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var teacherNameLabel: UILabel!
    
    var confirmHandler: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = course.name
        let startTime = course.startTime?.toFormat("MM月dd日 EE HH:mm", locale: Locales.chinese)
        let endTime = course.endTime?.toFormat("HH:mm")
        if let startTime = startTime, let endTime = endTime {
            timeLabel.text = "\(startTime)-\(endTime)"
        }
        headImageView.kf.setImage(with: URL(string: course.teacherPic?.fullURLString ?? ""))
        teacherNameLabel.text = course.teacherName
        
    }

    @IBAction func onSubscribeButtonPressed(sender: Any) {
        dismiss(animated: true, completion: confirmHandler)
    }
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
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
