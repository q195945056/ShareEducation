//
//  PayResultViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/16.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit

class PayResultViewController: UIViewController {
    
    @IBOutlet var viewOrderButton: UIButton!
    
    @IBOutlet var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "付款"
        viewOrderButton.layer.borderWidth = 1
        viewOrderButton.layer.borderColor = UIColor(red: 51, green: 51, blue: 51).cgColor
        viewOrderButton.layer.cornerRadius = 15
        viewOrderButton.layer.masksToBounds = true
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(red: 51, green: 51, blue: 51).cgColor
        backButton.layer.cornerRadius = 15
        backButton.layer.masksToBounds = true
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
