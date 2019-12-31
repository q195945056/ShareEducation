//
//  CourseDetailTeacherCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseDetailTeacherCell: UITableViewCell {
    
    @IBOutlet var headImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    var course: CourseItem? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let course = course {
            if let pic = course.teacherPic {
                headImageView.kf.setImage(with: URL(string: pic.fullURLString))
            }
            nameLabel.text = course.teacherName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
