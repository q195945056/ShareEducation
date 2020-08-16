//
//  CoursePlayViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly
import SwiftyJSON

class CoursePlayViewController: UIViewController {
    
    @IBOutlet var playerContainerView: UIView!
        
    @IBOutlet var segmentedControl: YLSegmentedControl!
    
    lazy var playerController = PlayerViewController()
    
    /// 课程详情控制器
    lazy var courseDescriptionController = CourseDescriptionViewController().then {
        $0.course = course
    }
    
    /// 问答控制器
    lazy var answerController = AskAnswerViewController().then{ $0.courseID = self.course.id }
    
    /// 讲义控制器
    lazy var lectureController = LectureNoteViewController()
    
    var course: CourseItem!
    
    lazy var commentItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "icon_share2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(onCommentButtonPressed(_:)))
        return barButtonItem
    }()
    
    lazy var shareItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "icon_share")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(onShareButtonPressed(_:)))
        return barButtonItem
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.scrollView?.isScrollEnabled = false
        return pageViewController
    }()
    
    var animator: Animator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        navigationItem.rightBarButtonItems = [shareItem, commentItem]
        addChild(playerController)
        playerContainerView.addSubview(playerController.view)
        playerController.didMove(toParent: self)
        playerController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(playerContainerView)
        }
        segmentedControl.items = ["课程简介", "问答", "讲义"]
        segmentedControl.defaultSegmentFont = .systemFont(ofSize: 13, weight: .medium)
        segmentedControl.selectedSegmentFont = .systemFont(ofSize: 13, weight: .medium)
        segmentedControl.aligment = .center
        segmentedControl.widthOption = .custom(value: 50)
        segmentedControl.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
        segmentedControl.showIndicator = true
        segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(playerController.view.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(46)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }

        pageViewController.setViewControllers([courseDescriptionController], direction: .forward, animated: false)
    }
    
    func loadData() {
        
        serviceProvider.request(.playCourse(id: course.id)) {  result in
            let json = try? result.get().mapJSON()
            if let json = json {
                let jsonData = JSON(json)
                let status = jsonData["result"].numberValue
                if status == 1 {
                    let data = jsonData["data"]
                    let playurl = data["playurl"].stringValue
                    if !playurl.isEmpty {
                        self.playerController.urlString = playurl
                        self.playerController.prepareToPlay()
                    }
                }
            }
        }
    }
    
    var selectedIndex: NSInteger = -1
    
    @IBAction func onSegmentedControlValueChanged(_ sender: YLSegmentedControl) {
        guard sender.selectedSegmentIndex != selectedIndex else {
            return
        }
        
        let controller = contentController(at: sender.selectedSegmentIndex)
        var direction = UIPageViewController.NavigationDirection.reverse
        if sender.selectedSegmentIndex > selectedIndex {
            direction = .forward
        }
        pageViewController.setViewControllers([controller], direction: direction, animated: true)
        selectedIndex = sender.selectedSegmentIndex
    }
    
    func contentController(at index: Int) -> UIViewController {
        if index == 0 {
            return courseDescriptionController
        } else if index == 1 {
            return answerController
        } else {
            return lectureController
        }
    }

    @objc func onShareButtonPressed(_ sender: Any) {
        
    }

    @objc func onCommentButtonPressed(_ sender: Any) {
        let controller = CommentViewController()
        let size = PresentationSize(width: .fullscreen, height: .fullscreen)
        let marginGuards = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 0, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        present(controller, animated: true)
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

extension CoursePlayViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass || traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            if traitCollection.verticalSizeClass == .compact { //横屏
                playerContainerView.snp.remakeConstraints { (make) in
                    make.edges.equalTo(view)
                }
//                tableView.isHidden = true
                navigationController?.setNavigationBarHidden(true, animated: true)
            } else {
                playerContainerView.snp.remakeConstraints { (make) in
                    make.top.leading.trailing.equalTo(view)
                    make.height.equalTo(211)
                }
//                tableView.isHidden = true
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
}
