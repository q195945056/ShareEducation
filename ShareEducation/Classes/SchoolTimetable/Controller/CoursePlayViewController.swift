//
//  CoursePlayViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly

class CoursePlayViewController: UIViewController {
    
    @IBOutlet var playerContainerView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    lazy var playerController = PlayerViewController()
    
    lazy var commentItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "icon_share2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(onCommentButtonPressed(_:)))
        return barButtonItem
    }()
    
    lazy var shareItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "icon_share")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(onShareButtonPressed(_:)))
        return barButtonItem
    }()
    
    var animator: Animator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    }
    
    func setupUI() {
        addChild(playerController)
        playerContainerView.addSubview(playerController.view)
        playerController.didMove(toParent: self)
        playerController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(playerContainerView)
        }
        navigationItem.rightBarButtonItems = [shareItem, commentItem]
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
                tableView.isHidden = true
                navigationController?.setNavigationBarHidden(true, animated: true)
            } else {
                playerContainerView.snp.remakeConstraints { (make) in
                    make.top.leading.trailing.equalTo(view)
                    make.height.equalTo(211)
                }
                tableView.isHidden = true
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
}
