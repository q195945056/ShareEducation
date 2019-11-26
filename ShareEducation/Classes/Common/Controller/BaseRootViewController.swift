//
//  RootBaseViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/16.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import Jelly
import BetterSegmentedControl

class BaseRootViewController: UIViewController {
    
    // MARK: - Property
    lazy var customNavigationBar: CustomNavigationBar = CustomNavigationBar(type: .normal)
    
    lazy var segmentedControl: YLSegmentedControl = YLSegmentedControl(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 44),items: ["全部", "语文", "数学", "英语", "物理", "化学", "政治"]).then {
        $0.addTarget(self, action: #selector(onSegmentedControlValueChanged(sender:)), for: .valueChanged)
        $0.contentInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        $0.showIndicator = true
        $0.widthOption = .custom(value: 37)
    }
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.scrollView?.isScrollEnabled = false
        return pageViewController
    }()
    
    var animator: Animator?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    
        NotificationCenter.default.addObserver(forName: ShareSetting.gradeDidChangeNotification, object: nil, queue: nil) { (notification) in
            let grade = notification.object as! Grade
            self.customNavigationBar.gradeLabel.text = grade.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI() -> Void {
        customNavigationBar.gradeLabel.text = ShareSetting.shared.grade.name

        view.addSubview(customNavigationBar)
        view.addSubview(segmentedControl)
        view.addSubview(pageViewController.view)
        customNavigationBar.snp.makeConstraints { (make) in
        make.top.equalTo(view).offset(UIApplication.shared.statusBarFrame.height)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(44)
        }
        segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(customNavigationBar.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(44)
        }
        pageViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        let viewController = contentViewController()
        if let viewController = viewController {
            pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
        }
        
        customNavigationBar.gradeButton.addTarget(self, action: #selector(onGradeButtonPressed(sender:)), for: .touchUpInside)
        customNavigationBar.historyButton.addTarget(self, action: #selector(onHistoryButtonPressed(sender:)), for: .touchUpInside)
        customNavigationBar.locationButton.addTarget(self, action: #selector(onLocationButtonPressed(sender:)), for: .touchUpInside)
        
    }
    
    func contentViewController(course: Course = .default) -> BaseContentViewController?  {
        return nil
    }
    
    // MARK: - Actions
    
    @objc func onGradeButtonPressed(sender: AnyObject)  {
        let controller = GradeSettingViewController()
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 370))
        let marginGuards = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 15, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        present(controller, animated: true)
    }
    
    @objc func onHistoryButtonPressed(sender: AnyObject) {
         
    }
    
    @objc func onLocationButtonPressed(sender: AnyObject) {
         
    }
    
    @objc func onSegmentedControlValueChanged(sender: YLSegmentedControl) {
    
    }
    
}
