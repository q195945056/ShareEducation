//
//  UIViewController+BackButtonTitle.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/23.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func clearNextControllerBackButtonTitle() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
