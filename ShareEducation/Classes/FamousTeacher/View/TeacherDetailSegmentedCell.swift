//
//  TeacherDetailSegmentedCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherDetailSegmentedCell: UITableViewCell {
    
    @IBOutlet var segmentedControl: YLSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        segmentedControl.items = ["课程", "介绍", "评价"]
        segmentedControl.aligment = .center
        segmentedControl.widthOption = .custom(value: 40)
        segmentedControl.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        segmentedControl.showIndicator = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
