//
//  BaseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class BaseContentViewController: UIViewController {
    var course: Course = Course(id: 0, name: "全部")
    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(gradeDidChange(_:)), name: ShareSetting.gradeDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(areaDidChange(_:)), name: ShareSetting.areaDidChangeNotification, object: nil)
    }
    
    @objc func gradeDidChange(_ notification: Notification) {
        
    }
    
    @objc func areaDidChange(_ notification: Notification) {
        
    }
}
