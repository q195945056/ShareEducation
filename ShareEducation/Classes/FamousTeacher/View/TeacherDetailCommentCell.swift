//
//  TeacherDetailAppraiseCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/27.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherDetailCommentCell: UITableViewCell {
    
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var ratingView: StarRatingView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    var comment: Comment? {
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
