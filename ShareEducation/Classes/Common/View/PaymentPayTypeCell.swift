//
//  PaymentPayTypeCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class PaymentPayTypeCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var selectIndicatorImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectIndicatorImageView.image = UIImage(named: "icon_sel")
        } else {
            selectIndicatorImageView.image = UIImage(named: "icon_sel2")
        }
    }
}
