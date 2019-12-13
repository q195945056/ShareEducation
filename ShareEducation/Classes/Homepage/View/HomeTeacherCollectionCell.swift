//
//  HomeTeacherCollectionCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/10.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class HomeTeacherCollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var rankingImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var starRateView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    
    
    var ranking: Int = 0 {
        didSet {
            switch ranking {
            case 1, 2, 3:
                rankingImageView.isHidden = false
                rankingImageView.image = UIImage(named: "tag_NO\(ranking)")
            default:
                rankingImageView.isHidden = true
            }
        }
    }
    
    var teacher: Teacher? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        let urlString = teacher?.pic?.fullURLString
        if let urlString = urlString {
            imageView.kf.setImage(with: URL(string: urlString))
        }
        nameLabel.text = teacher?.truename
        levelLabel.text = teacher?.title
        starRateView.image = UIImage(named: "start\(teacher?.score ?? 1)")
        scoreLabel.text = String(teacher?.score ?? 1)
        addressLabel.text = teacher?.city
        schoolNameLabel.text = teacher?.university
        ageLabel.text = "\(teacher?.teachingage ?? 1)年教龄"
    }
}
