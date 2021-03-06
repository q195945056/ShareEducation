//
//  SchoolTimetableViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/10/22.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Jelly

class SchoolTimetableViewController: BaseRootViewController {
    
    // MARK: - Property
    
    let naviBar = CustomNavigationBar(type: .segment)
    
    override var customNavigationBar: CustomNavigationBar {
        get {
            naviBar
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        naviBar.segmentedControl.addTarget(self, action: #selector(onPlaybackSegmentedValueChange(_:)), for: .valueChanged)
    }
    
    override func contentViewController(course: Course = .default) -> BaseContentViewController? {
        return CourseContentViewController(course: course)
    }
    
    @objc func onPlaybackSegmentedValueChange(_ sender: BetterSegmentedControl) {
        let controller = contentController as! CourseContentViewController
        controller.playType = CoursePlayType(rawValue: sender.index + 1)!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
