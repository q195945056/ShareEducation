//
//  CourseDetailDescptionCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseDetailDescptionCell: UITableViewCell {
    
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var watchButton: UIButton!
    
    var course: CourseItem? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let course = course {
            descriptionLabel.text = course.depict
            priceLabel.text = String(course.price ?? 0)
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
