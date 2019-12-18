//
//  YLPageViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/15.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

protocol YLPageViewControllerDataSource : NSObjectProtocol {
    
    func pageViewController(_ pageViewController: YLPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?

    func pageViewController(_ pageViewController: YLPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
}

protocol YLPageViewControllerDelegate : NSObjectProtocol {
    
    func pageViewController(_ pageViewController: YLPageViewController, willTransitionTo viewControllers: [UIViewController])
    
    func pageViewController(_ pageViewController: YLPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
}

extension YLPageViewControllerDelegate {
    func pageViewController(_ pageViewController: YLPageViewController, willTransitionTo viewControllers: [UIViewController]) {}
    
    func pageViewController(_ pageViewController: YLPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {}
}

class YLPageViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    weak var delegate: YLPageViewControllerDelegate?
    
    weak var dataSource: YLPageViewControllerDataSource?
    
    var viewControllers = [UIViewController]()
    
    var currentViewController: UIViewController?
    
    var willTransitionToController: UIViewController?
    
    var completion: ((Bool) -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (m) in
            m.edges.equalTo(view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    enum NavigationDirection {
        case forward
        case backward
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
        for (index, controller) in viewControllers.enumerated() {
            controller.view.frame = CGRect(x: CGFloat(index) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        }
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]?, direction: NavigationDirection, animated: Bool, completion: ((Bool) -> Void)?) {
        currentViewController = viewControllers?.first
        if let viewControllers = viewControllers {
            delegate?.pageViewController(self, willTransitionTo: viewControllers)
        }
        if self.viewControllers.count == 0 || !animated {
            updateContentViewControllers()
            if let completion = completion {
                completion(true)
            }
        } else {
            self.completion = completion
            scrollView.isScrollEnabled = false
            addChild(currentViewController!)
            scrollView.addSubview(currentViewController!.view)
            currentViewController!.didMove(toParent: self)
            var index: Int = 0
            if direction == .forward {
                index = 2
            }
            let controller = self.viewControllers[index]
            controller.view.isHidden = true
            currentViewController?.view.frame = CGRect(x: scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(index), y: 0), animated: animated)
        }
    }
    
    func updateContentViewControllers() {
        for viewController in viewControllers {
            viewController.willMove(toParent: nil)
            viewController.removeFromParent()
            viewController.view.removeFromSuperview()
        }
        viewControllers.removeAll()
        let controller = currentViewController!
        let leftController = dataSource?.pageViewController(self, viewControllerBefore: controller)
        let rightController = dataSource?.pageViewController(self, viewControllerAfter: controller)
        addChild(leftController!)
        scrollView.addSubview(leftController!.view)
        leftController!.didMove(toParent: self)
        addChild(controller)
        scrollView.addSubview(controller.view)
        controller.didMove(toParent: self)
        addChild(rightController!)
        scrollView.addSubview(rightController!.view)
        rightController!.didMove(toParent: self)
        viewControllers.append(leftController!)
        viewControllers.append(controller)
        viewControllers.append(rightController!)
        for (i, controller) in viewControllers.enumerated() {
            controller.view.frame = CGRect(x: CGFloat(i) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        }
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

extension YLPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging || scrollView.isDecelerating {
            let contentOffset = scrollView.contentOffset
            let index = round(contentOffset.x / scrollView.frame.width)
            let controller = viewControllers[Int(index)]
            if controller != willTransitionToController {
                willTransitionToController = controller
                delegate?.pageViewController(self, willTransitionTo: [controller])
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollEnd()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnd()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
        DispatchQueue.main.async {
            scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
            if let completion = self.completion {
                self.updateContentViewControllers()
                completion(true)
                self.completion = nil
            }
        }
    }
    
    func scrollEnd() {
        let contentOffset = scrollView.contentOffset
        let index = Int(contentOffset.x / scrollView.frame.width)
        if index != 1 {
            let controller = viewControllers[index]
            currentViewController = controller
            
            let previousController = viewControllers[1]
            delegate?.pageViewController(self, didFinishAnimating: true, previousViewControllers: [previousController], transitionCompleted: true)
        }
        updateContentViewControllerAfterScroll()
    }
    
    func updateContentViewControllerAfterScroll() {
        let contentOffset = scrollView.contentOffset
        let delta = scrollView.frame.width - contentOffset.x
        
        for controller in viewControllers {
            var frame = controller.view.frame
            frame.origin.x += delta
            controller.view.frame = frame
        }
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        
        if delta < 0 {//向右滑动
            let rightController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController!)
            rightController?.view.frame = CGRect(x: scrollView.frame.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            let tempController = viewControllers.first
            tempController?.willMove(toParent: nil)
            tempController?.removeFromParent()
            tempController?.view.removeFromSuperview()
            addChild(rightController!)
            scrollView.addSubview(rightController!.view)
            rightController?.didMove(toParent: self)
            viewControllers.remove(at: 0)
            viewControllers.append(rightController!)
        } else if delta > 0 {
            let leftController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController!)
            leftController?.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            let tempController = viewControllers.last
            tempController?.willMove(toParent: nil)
            tempController?.removeFromParent()
            tempController?.view.removeFromSuperview()
            addChild(leftController!)
            scrollView.addSubview(leftController!.view)
            leftController?.didMove(toParent: self)
            viewControllers.remove(at: 2)
            viewControllers.insert(leftController!, at: 0)
        }
    }
}
