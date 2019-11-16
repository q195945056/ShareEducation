//
//  HomePageViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/10/22.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import SnapKit
import Jelly

class HomePageViewController: UIViewController {
    
    // MARK: - Property
    
    let segmentedControl: BetterSegmentedControl = BetterSegmentedControl().then {
        $0.indicatorViewBackgroundColor = .white
        $0.segments = LabelSegment.segments(withTitles: ["全部", "语文", "数学", "英语", "物理", "化学", "政治"],
        normalFont: .systemFont(ofSize: 13),
        normalTextColor: UIColor(red: 51, green: 51, blue: 51),
        selectedFont: .systemFont(ofSize: 18, weight: .medium),
        selectedTextColor: UIColor(red: 233, green: 76, blue: 28))
    }
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.scrollView?.isScrollEnabled = false
        return pageViewController
    }()
    
    var animator: Animator?
    
    var customNavigationBar: CustomNavigationBar = CustomNavigationBar(frame: .zero).then{
        $0.gradeButton.addTarget(self, action: #selector(onGradeButtonPressed(sender:)), for: .touchUpInside)
        $0.historyButton.addTarget(self, action: #selector(onHistoryButtonPressed(sender:)), for: .touchUpInside)
        $0.locationButton.addTarget(self, action: #selector(onLocationButtonPressed(sender:)), for: .touchUpInside)
    }
        
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func _setupUI() -> Void {
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
        

        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "HomeContentViewController")
        if let viewController = viewController {
            pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


