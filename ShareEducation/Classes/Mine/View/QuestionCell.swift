//
//  QuestionCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/5.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var indicatorImageView: UIImageView!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet var lineView: UIView!
    
    var question: Question? {
        didSet {
            titleLabel.text = question?.question
            descriptionLabel.text = question?.answer
            if let expand = question?.expand, expand == true {
                bottomConstraint.isActive = true
                heightConstraint.isActive = false
                descriptionLabel.alpha = 1
                indicatorImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            } else {
                bottomConstraint.isActive = false
                heightConstraint.isActive = true
                descriptionLabel.alpha = 0
                indicatorImageView.transform = CGAffineTransform.identity
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
