//
//  CourseDetailUnitDescriptionCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseDetailUnitDescriptionCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!

    var course: CourseItem? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let course = course {
            descriptionLabel.text = course.unitDepict
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
