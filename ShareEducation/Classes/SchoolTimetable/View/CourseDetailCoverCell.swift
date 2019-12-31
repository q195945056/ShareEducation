//
//  CourseCoverCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class CourseDetailCoverCell: UITableViewCell {
    
    @IBOutlet var coverImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    var course: CourseItem? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let course = course {
            if let pic = course.pic {
                coverImageView.kf.setImage(with: URL(string: pic.fullURLString))
            }
            titleLabel.text = course.name
            let startTime = course.startTime?.toFormat("MM月dd日 EE HH:mm", locale: Locales.chinese)
            let endTime = course.endTime?.toFormat("HH:mm")
            if let startTime = startTime, let endTime = endTime {
                timeLabel.text = "时间：\(startTime)-\(endTime)"
            }
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
