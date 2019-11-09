//
//  UIPageViewController+ScrollView.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

extension UIPageViewController {
    
    var scrollView: UIScrollView?  {
        var result: UIScrollView?
        let subViews = view.subviews
        for subView in subViews {
            if subView is UIScrollView {
                result = subView as? UIScrollView
                break
            }
        }
        return result
    }
    
}
