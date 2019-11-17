//
//  HomePageViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/10/22.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class HomePageViewController: BaseRootViewController {
    
    // MARK: - Property


        
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() -> Void {
        super.setupUI()
        
    }
    
    override func contentViewController() -> BaseContentViewController?  {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "HomeContentViewController") as? BaseContentViewController
        return viewController
    }
    
    // MARK: - Actions
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


