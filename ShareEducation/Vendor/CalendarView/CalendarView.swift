//
//  CalendarView.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

protocol CalendarViewDataSource {
    
}

protocol CalendarViewDelegate: AnyObject {
    func calendarView(_ calendarView: CalendarView, heightWillChangeTo height: CGFloat)
}

extension CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, heightWillChangeTo height: CGFloat) {}
}

class CalendarView: UIView {
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    var height: CGFloat = 0
    
    lazy var pageViewController: YLPageViewController = {
        let controller = YLPageViewController()
        controller.dataSource = self
        controller.delegate = self
        return controller
    }()
    
    weak var delegate: CalendarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        clipsToBounds = true
        addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(500)
        }
        let controller = MonthViewController(month: Date())
        height = controller.size.height
        invalidateIntrinsicContentSize()
        pageViewController.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
    
    func goToPreviousMonth() {
        
    }
    
}

extension CalendarView: YLPageViewControllerDataSource {
    func pageViewController(_ pageViewController: YLPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! MonthViewController
        let date = controller.month
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let nextMonth = date + dateComponents
        return MonthViewController(month: nextMonth)
    }
    
    func pageViewController(_ pageViewController: YLPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! MonthViewController
        let date = controller.month
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let nextMonth = date - dateComponents
        return MonthViewController(month: nextMonth)
    }
}

extension CalendarView: YLPageViewControllerDelegate {
    func pageViewController(_ pageViewController: YLPageViewController, willTransitionTo viewControllers: [UIViewController]) {
        let controller = viewControllers.first as! MonthViewController
        height = controller.size.height
        invalidateIntrinsicContentSize()
        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded()
            self.delegate?.calendarView(self, heightWillChangeTo: self.height)
        }
    }
    
    func pageViewController(_ pageViewController: YLPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }

}
