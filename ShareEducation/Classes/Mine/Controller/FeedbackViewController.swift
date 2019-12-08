//
//  FeedbackViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/7.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var contactField: UITextField!
    
    @IBOutlet var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
         
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
