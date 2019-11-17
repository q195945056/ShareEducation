//
//  MineTableHeaderView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/17.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class MineTableHeaderView: UIView {
    
    var loginHandler: (() -> Void)?
    
    lazy var loginControl = UIControl().then { view in
        view.backgroundColor = .clear
        let imageView = UIImageView(image: UIImage(named: "bg_myinfo"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(-14 - onePixelWidth)
            make.leading.equalTo(view).offset(-15)
            make.trailing.equalTo(view).offset(15)
            make.bottom.equalTo(view).offset(14 + onePixelWidth)
            make.height.equalTo(imageView.snp.width).multipliedBy(imageView.image!.size.height / imageView.image!.size.width)
        }
        
        let titleLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: UIColor.e64919)
        titleLabel.text = "登录/注册"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(18)
            make.top.equalTo(view).offset(20)
        }
        
        let descriptionLabel = UILabel(font: .systemFont(ofSize: 16), textColor: UIColor.darkTextColor)
        descriptionLabel.text = "Hi，欢迎来到共享教育"
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        view.addTarget(self, action: #selector(onLoginButtonPreesed(sender:)), for: .touchUpInside)
    }
    
    lazy var headImageView = UIImageView().then {
        $0.layer.cornerRadius = 27.5
        $0.layer.masksToBounds = true
    }
    
    lazy var nameLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .black)
    
    lazy var phoneLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .lightTextColor)
    
    lazy var gradeLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .lightTextColor)
    
    lazy var infoButton = UIButton(backgroundImage: UIImage(named: "tag_student"), target: self, selector: #selector(onInfoButtonPressed(sender:)))

    lazy var userInfoView = UIView().then { view in
        view.backgroundColor = .clear
        let imageView = UIImageView(image: UIImage(named: "bg_myinfo2"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(-14 - onePixelWidth)
            make.leading.equalTo(view).offset(-15)
            make.trailing.equalTo(view).offset(15)
            make.bottom.equalTo(view).offset(14 + onePixelWidth)
            make.height.equalTo(imageView.snp.width).multipliedBy(imageView.image!.size.height / imageView.image!.size.width)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let bgImage = UIImage(named: "bg_my")!
        let bgImageView = UIImageView(image: bgImage)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(bgImageView.snp.width).multipliedBy(bgImage.size.height / bgImage.size.width)
        }
        
        let logoImageView = UIImageView(image: UIImage(named: "logo_my"))
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(14 + onePixelWidth)
            make.top.equalTo(self).offset(20 + actualStatusBarHeight)
        }
        
        let settingButton = UIButton(image: UIImage(named: "icon_my_setting"), target: self, selector: #selector(onSettingButtonPressed(sender:)))
        addSubview(settingButton)
        settingButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-18)
            make.top.equalTo(self).offset(actualStatusBarHeight + 28)
        }
        
        addSubview(loginControl)
        loginControl.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(actualStatusBarHeight + 66 + onePixelWidth)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15).priority(.high)
        }
                
        let image: UIImage! = UIImage(named: "img_my")
        let inviteButton = UIButton(backgroundImage: image, target: self, selector: #selector(onInviteButtonPressed))
        addSubview(inviteButton)
        inviteButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginControl.snp.bottom).offset(18)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15).priority(.high)
            make.height.equalTo(inviteButton.snp.width).multipliedBy(image.size.height / image.size.width)
        }
        
        
    }
    
    @objc func onSettingButtonPressed(sender: AnyObject) {
        
    }
    
    @objc func onLoginButtonPreesed(sender: AnyObject) {
        if let loginHandler = loginHandler {
            loginHandler()
        }
    }
    
    @objc func onInfoButtonPressed(sender: AnyObject) {
        
    }
    
    @objc func onInviteButtonPressed() {
        
    }
    
}
