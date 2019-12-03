//
//  CoursePlayViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CoursePlayViewController: UIViewController {
    
    @IBOutlet var playerContainerView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    lazy var playerController = PlayerViewController()

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
