//
//  SplashView.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class SplashView: UIView {
    
    static var canShowSplash: Bool {
        let shareData = ShareData.shared
        let resource = shareData.splashResources?.first
        if let _ = resource {
            return true
        } else {
            return false
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
        let resource = (ShareData.shared.splashResources?.first)!
        imageView.kf.setImage(with: URL(string: resource.img.fullURLString))
        return imageView
    }()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.removeFromSuperview()
//        }
    }

}
