//
//  CouponCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/4.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {
    
    @IBOutlet var contentBgView: UIView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var limitLabel: UILabel!
    
    @IBOutlet var valideDateLabel: UILabel!
    
    @IBOutlet var receiveButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
