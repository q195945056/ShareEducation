//
//  CourseDetailUnitCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class CourseDetailUnitCell: UITableViewCell {
    
    @IBOutlet var rankingLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var statusLable: UILabel!
    
    var unit: CourseUnit? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let unit = unit {
            titleLabel.text = unit.name
            var play = "直播"
            if unit.state == CourseItem.PlayState.record {
                play = "回放"
            }
            let startTime = unit.startTime?.toFormat("MM月dd日 EE HH:mm", locale: Locales.chinese)
            let endTime = unit.endTime?.toFormat("HH:mm")
            if let startTime = startTime, let endTime = endTime {
                timeLabel.text = "\(play)｜\(startTime)-\(endTime)"
            }
            
            if unit.startTime! < Date() {
                statusLable.text = "未开始"
            } else if unit.endTime! > Date() {
                statusLable.text = "已结束"
            } else {
                statusLable.text = "正在直播"
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
