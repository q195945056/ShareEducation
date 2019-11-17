//
//  MainTabbarController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
