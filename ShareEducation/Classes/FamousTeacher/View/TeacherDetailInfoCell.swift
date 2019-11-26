//
//  TeacherDetailInfoCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class TeacherDetailInfoCell: UITableViewCell {
    
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starRateImageView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var attentionButton: UIButton!
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var teachAgeLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var teachTimeLabel: UILabel!
    @IBOutlet var playCountLabel: UILabel!
    
    var teacher: Teacher? {
        didSet {
            updateUI()
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
    
    func updateUI() {
        let urlString = teacher?.pic?.fullURLString
        if let urlString = urlString {
            headImageView.kf.setImage(with: URL(string: urlString))
        }
        nameLabel.text = teacher?.trueName
        starRateImageView.image = UIImage(named: "start\(teacher?.score ?? 1)")
        scoreLabel.text = String(teacher?.score ?? 1)
        schoolNameLabel.text = teacher?.university
        titleLabel.text = teacher?.title
        teachAgeLabel.text = "\(teacher?.teachingAge ?? 1)年教龄"
        rankingLabel.text = "第\(12)位"
        teachTimeLabel.text = String(teacher?.totletime ?? 0) + "分钟"
        playCountLabel.text = String(teacher?.playCount ?? 0) + "次"
    }
    
}
