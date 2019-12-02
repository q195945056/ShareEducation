//
//  FamousTeacherViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/10/22.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import Jelly

class FamousTeacherViewController: BaseRootViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func contentViewController(course: Course = .default) -> BaseContentViewController?  {
        let viewController = TeacherContentViewController(course: course)
        return viewController
    }
        

    // MARK: - Actions
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
