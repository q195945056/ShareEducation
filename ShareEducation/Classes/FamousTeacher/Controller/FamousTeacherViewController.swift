//
//  FamousTeacherViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/10/22.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly

class FamousTeacherViewController: UIViewController {
    
    var animator: Animator?
    
    var customNavigationBar: CustomNavigationBar = CustomNavigationBar(frame: .zero).then{
        $0.gradeButton.addTarget(self, action: #selector(onGradeButtonPressed(sender:)), for: .touchUpInside)
        $0.historyButton.addTarget(self, action: #selector(onHistoryButtonPressed(sender:)), for: .touchUpInside)
        $0.locationButton.addTarget(self, action: #selector(onLocationButtonPressed(sender:)), for: .touchUpInside)
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
    
    private func setupUI() -> Void {
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
