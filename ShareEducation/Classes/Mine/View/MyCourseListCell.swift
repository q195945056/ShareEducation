//
//  MyCourseListCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/8/2.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit

class MyCourseListCell: UITableViewCell {
    
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var teacherInfoLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
     
    @IBOutlet var actionButton: UIButton!
    
    @IBOutlet var contentBgView: UIView!

    var buyHandler: ((_ course: CourseItem?) -> Void)?
    
    var course: CourseItem? {
        didSet {
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
