//
//  BaseContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class BaseContentViewController: UIViewController {
    var grade: Grade = Grade(id: 0, name: "全部")
    
    var course: Course = Course(id: 0, name: "全部")
    
    init(grade: Grade, course: Course) {
        self.grade = grade
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
