//
//  CourseUnitFooterView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/28.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CourseUnitFooterView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    static var height: CGFloat = 67 + onePixelWidth
    
    lazy var viewAllButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.backgroundColor = .f5f5f5
        button.layer.cornerRadius = 12.5
        button.layer.masksToBounds = true
        button.setTitle("查看全部12次课", for: .normal)
        button.setTitleColor(.darkTextColor, for: .normal)
        button.addTarget(self, action: #selector(onViewAllButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let view: UIView = UIView()
        view.backgroundColor = .white
        contentView.addSubview(view)
        view.addSubview(viewAllButton)
        view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(CourseUnitFooterView.height)
        }
        
        viewAllButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(22)
            make.centerX.equalTo(contentView)
            make.width.equalTo(115)
            make.height.equalTo(25)
        }
    }
    
    //MARK: - Actions
    
    @objc func onViewAllButtonPressed(sender: Any) {
        
    }
    
}
