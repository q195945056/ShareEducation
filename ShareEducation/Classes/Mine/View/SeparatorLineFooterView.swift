//
//  SeparatorLineFooterView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SeparatorLineFooterView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var lineView: UIView! = UIView().then {
        $0.backgroundColor = UIColor(red: 234, green: 234, blue: 234)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.backgroundColor = .white
        let view = UIView()
        view.backgroundColor = .white
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(13).priority(.high)
            make.trailing.equalTo(contentView)
            make.height.equalTo(onePixelWidth)
            make.centerY.equalTo(contentView)
        }
    }
    
}
