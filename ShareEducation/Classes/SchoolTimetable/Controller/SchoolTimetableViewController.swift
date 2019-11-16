//
//  SchoolTimetableViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/10/22.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Jelly

class SchoolTimetableViewController: UIViewController {
    
    class CustomNavigationBar: UIView {
        
        // MARK: - Property
        let gradeLabel = UILabel().then { (label) in
            label.font = .systemFont(ofSize: 13, weight: .bold)
            label.textColor = .textColor
            label.text = "年级"
        }
        
        lazy var gradeButton: UIControl = {
            let control = UIControl()
            let imageView = UIImageView(image: UIImage(named: "icon_grade"))
            control.addSubview(gradeLabel)
            control.addSubview(imageView)
            gradeLabel.snp.makeConstraints { (make) in
                make.leading.top.bottom.equalTo(control)
            }
            imageView.snp.makeConstraints { (make) in
                make.leading.equalTo(gradeLabel.snp.trailing).offset(5)
                make.trailing.equalTo(control)
                make.centerY.equalTo(control)
            }
            return control
        }()
        
        let searchButton = UIButton().then{
            $0.setImage(UIImage(named: "icon_search_class"), for: .normal)
        }
        
        let segmentedControl: BetterSegmentedControl = BetterSegmentedControl().then {
            $0.indicatorViewBackgroundColor = .e64919
            $0.indicatorViewInset = 0
            $0.cornerRadius = 12.5
            $0.layer.borderColor = UIColor.e64919.cgColor
            $0.layer.borderWidth = 1 / UIScreen.main.scale
            $0.segments = LabelSegment.segments(withTitles: ["直播", "回放"],
            normalFont: .systemFont(ofSize: 15),
            normalTextColor: .e64919,
            selectedFont: .systemFont(ofSize: 15),
            selectedTextColor: .white)
        }
            
        // MARK: - Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            commonInit()
        }
        
        func commonInit() {
            addSubview(gradeButton)
            addSubview(segmentedControl)
            addSubview(searchButton)
            
            gradeButton.snp.makeConstraints { (make) in
                make.leading.equalTo(self).offset(13)
                make.centerY.equalTo(self)
            }
            
            segmentedControl.snp.makeConstraints { (make) in
                make.center.equalTo(self)
                make.width.equalTo(128)
                make.height.equalTo(25)
            }
            
            searchButton.snp.makeConstraints { (make) in
                make.trailing.equalTo(self).offset(-13)
                make.centerY.equalTo(self)
            }
        }
        
    }
    
    var animator: Animator?

    
    var customNavigationBar: SchoolTimetableViewController.CustomNavigationBar = SchoolTimetableViewController.CustomNavigationBar(frame: .zero).then{
        $0.gradeButton.addTarget(self, action: #selector(onGradeButtonPressed(sender:)), for: .touchUpInside)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI() {
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints { (make) in
        make.top.equalTo(view).offset(UIApplication.shared.statusBarFrame.height)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(44)
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
