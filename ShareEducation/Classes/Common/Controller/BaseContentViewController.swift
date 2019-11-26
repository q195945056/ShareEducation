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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
