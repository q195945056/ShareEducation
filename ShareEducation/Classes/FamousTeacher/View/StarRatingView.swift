//
//  StarRatingView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/27.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

@IBDesignable class StarRatingView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var score: Int {
        didSet {
            image = UIImage(named: "start\(score)")
        }
    }
    
    override init(frame: CGRect) {
        score = 1
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        score = 1
        super.init(coder: coder)
    }

}
