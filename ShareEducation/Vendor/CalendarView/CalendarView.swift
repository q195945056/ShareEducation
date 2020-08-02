//
//  CalendarView.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

protocol CalendarViewDataSource: NSObjectProtocol {
    func calendarView(_ calendarView: CalendarView, haveEventAt date: Date) -> Bool
}

protocol CalendarViewDelegate: AnyObject {
    func calendarView(_ calendarView: CalendarView, heightWillChangeTo height: CGFloat)
    func calendarView(_ calendarView: CalendarView, didChangeToMonth month: Date)
}

extension CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, heightWillChangeTo height: CGFloat) {}
    func calendarView(_ calendarView: CalendarView, didChangeToMonth month: Date) {}
}

class CalendarView: UIView {
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    var date: Date {
        get {
            let controller = pageViewController.currentViewController as! CalendarViewController
            return controller.date
        }
    }
    
    var height: CGFloat = 0
    
    lazy var pageViewController: YLPageViewController = {
        let controller = YLPageViewController()
        controller.dataSource = self
        controller.delegate = self
        return controller
    }()
    
    var type: CalendarViewController.CalendarType = .month
    
    weak var delegate: CalendarViewDelegate?
    
    weak var dataSource: CalendarViewDataSource?
    
    init(frame: CGRect, type: CalendarViewController.CalendarType = .month) {
        self.type = type
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
        let controller = CalendarViewController(type: type, date: Date())
        controller.dataSource = self
        controller.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width - 26, height: 0)
        height = controller.size.height
        invalidateIntrinsicContentSize()
        pageViewController.setViewControllers([controller], direction: .forward, animated: false) { _ in
            self.notifyDelegateMonthChange()
        }
    }
    
    func notifyDelegateMonthChange() {
        let controller = pageViewController.currentViewController as! CalendarViewController
        let date = controller.date
        delegate?.calendarView(self, didChangeToMonth: date)
    }
    
    func reloadData() {
        let controller = pageViewController.currentViewController as! CalendarViewController
        controller.reloadData()
    }
    
    func goToPreviousMonth() {
        let controller = pageViewController.currentViewController as! CalendarViewController
        let nextController = CalendarViewController(type: type, date: controller.previousDate)
        nextController.dataSource = self
        nextController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width - 26, height: 0)
        pageViewController.setViewControllers([nextController], direction: .backward, animated: true) { _ in
            self.notifyDelegateMonthChange()
        }
    }
    
    func goToNextMonth() {
        let controller = pageViewController.currentViewController as! CalendarViewController
        let nextController = CalendarViewController(type: type, date: controller.nextDate)
        nextController.dataSource = self
        nextController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width - 26, height: 0)
        pageViewController.setViewControllers([nextController], direction: .forward, animated: true) { _ in
            self.notifyDelegateMonthChange()
        }
    }
}

extension CalendarView: CalendarViewControllerDataSource {
    func calendarViewController(_ calendarViewController: CalendarViewController, haveEventAt date: Date) -> Bool {
        dataSource?.calendarView(self, haveEventAt: date) ?? false
    }
}

extension CalendarView: YLPageViewControllerDataSource {
    func pageViewController(_ pageViewController: YLPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! CalendarViewController
        let previousController = CalendarViewController(type: type, date: controller.previousDate)
        previousController.dataSource = self
        return previousController
    }
    
    func pageViewController(_ pageViewController: YLPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! CalendarViewController
        let nextController = CalendarViewController(type: type, date: controller.nextDate)
        nextController.dataSource = self
        return nextController
    }
}

extension CalendarView: YLPageViewControllerDelegate {
    func pageViewController(_ pageViewController: YLPageViewController, willTransitionTo viewControllers: [UIViewController]) {
        let controller = viewControllers.first as! CalendarViewController
        height = controller.size.height
        invalidateIntrinsicContentSize()
        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded()
            self.delegate?.calendarView(self, heightWillChangeTo: self.height)
        }
    }
    
    func pageViewController(_ pageViewController: YLPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyDelegateMonthChange()
    }

}
