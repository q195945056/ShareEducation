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

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: BetterSegmentedControl!
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.scrollView?.isScrollEnabled = false
        return pageViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _setupUI()
    }
    
    private func _setupUI() -> Void {
        segmentedControl.segments = LabelSegment.segments(withTitles: ["全部", "语文", "数学", "英语", "物理", "化学", "政治"],
                                                          normalFont: .systemFont(ofSize: 13),
                                                          normalTextColor: UIColor(red: 51, green: 51, blue: 51),
                                                          selectedFont: .systemFont(ofSize: 18, weight: .medium),
                                                          selectedTextColor: UIColor(red: 233, green: 76, blue: 28))
        view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    pageViewController.setViewControllers([HomeContentViewController()], direction: .forward, animated: false)
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


