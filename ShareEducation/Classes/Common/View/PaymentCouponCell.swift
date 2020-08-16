//
//  PaymentCouponCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class PaymentCouponCell: UITableViewCell {
    
    @IBOutlet var couponNumberLabel: UILabel!
    
    var couponNumber: Int = 0 {
        didSet {
            couponNumberLabel.text = String(format: "-￥%.2f", Float(couponNumber) / 100)
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
