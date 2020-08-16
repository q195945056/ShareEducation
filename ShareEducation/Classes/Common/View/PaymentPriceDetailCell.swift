//
//  PaymentPriceDetailCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/29.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class PaymentPriceDetailCell: UITableViewCell {
    
    var totalPrice: Int = 0
    
    var couponNumber: Int = 0
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var couponNumberLabel: UILabel!
    
    @IBOutlet var finalPriceLabel: UILabel!
    
    
    func updateUI() {
        totalPriceLabel.text = String(format: "￥%.2f", Float(totalPrice) / 100)
        couponNumberLabel.text = String(format: "￥-%.2f", Float(couponNumber) / 100)
        finalPriceLabel.text = String(format: "￥%.2f", Float(totalPrice - couponNumber) / 100)
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
