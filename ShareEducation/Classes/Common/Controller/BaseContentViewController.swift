//
//  BaseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class BaseContentViewController: UIViewController {
    var grade: String?
    var course: String?
    
    init(grade: String?, course: String?) {
        self.grade = grade
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
