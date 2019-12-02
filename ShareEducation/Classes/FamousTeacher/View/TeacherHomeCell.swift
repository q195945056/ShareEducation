//
//  TeacherHomeCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/1.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherHomeCell: UITableViewCell {
    
    @IBOutlet var contentBgView: UIView!
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starRateView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var teachAgeLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var videoPlayCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let backgroundImageView = UIImageView(image: UIImage(named: "bg_class"))
        contentBgView.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentBgView).offset(-14 - onePixelWidth)
            make.leading.equalTo(contentBgView).offset(-13)
            make.trailing.equalTo(contentBgView).offset(13)
            make.bottom.equalTo(contentBgView).offset(14 + onePixelWidth)
        }
            
            
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
