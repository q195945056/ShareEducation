//
//  CourseDescriptionViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/25.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class CourseDescriptionViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var headImageView: UIImageView!
    
    @IBOutlet var teacherInfoLabel: UILabel!
    
    @IBOutlet var courseLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var startRatingImageView: StarRatingView!
    
    @IBOutlet var playCountLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var course: CourseItem!
    
    var data: JSON? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateUI() {
        if let data = data {
            titleLabel.text = course.name
            let teacher = data["teacher"]
            let url = URL(string: teacher["pic"].string!)!
            headImageView.kf.setImage(with: url)
            teacherInfoLabel.text = "\(teacher["truename"].string ?? "") \(teacher["title"].string ?? "")"
            courseLabel.text = "学科：\(data[""])"
            descriptionLabel.text = data["depict"].stringValue
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
