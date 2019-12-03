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
    @IBOutlet var starRateView: StarRatingView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var teachAgeLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var videoPlayCountLabel: UILabel!
    @IBOutlet var collectButton: UIButton!
    
    var teacher: Teacher? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let teacher = teacher {
            if let pic = teacher.pic {
                headImageView.kf.setImage(with: URL(string: pic))
            }
            nameLabel.text = teacher.trueName
            starRateView.score = teacher.score!
            scoreLabel.text = String(teacher.score!)
            schoolNameLabel.text = teacher.schoolName
            titleLabel.text = teacher.title
            courseLabel.text = ""
            teachAgeLabel.text = "\(teacher.teachingAge!)年教龄"
            rankingLabel.text = "排名第\(12)位"
            videoPlayCountLabel.text = "视频播放\(teacher.playCount!)次"
            collectButton.isSelected = teacher.isCollect ?? false
        }
    }

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
    
    @IBAction func onCollectButtonPressed(_ sender: UIButton) {
        teacher?.collect(oper: !teacher!.isCollect!) { result in
            if result {
                self.collectButton.isSelected = self.teacher!.isCollect!
            }
        }
    }
    
}
