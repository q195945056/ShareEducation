//
//  SearchHotCell.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/4.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SearchHotCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

}
