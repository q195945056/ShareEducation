//
//  CourseDescriptionViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/25.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseDescriptionViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var headImageView: UIImageView!
    
    @IBOutlet var teacherInfoLabel: UILabel!
    
    @IBOutlet var courseLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var startRatingImageView: StarRatingView!
    
    @IBOutlet var playCountLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
