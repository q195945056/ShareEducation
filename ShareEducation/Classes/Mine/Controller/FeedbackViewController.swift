//
//  FeedbackViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/7.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import IQKeyboardManagerSwift

class FeedbackViewController: UIViewController {
    
    @IBOutlet var textView: RSKPlaceholderTextView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var contactField: UITextField!
    
    @IBOutlet var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enable = false
    }
    
    
    // MARK: - Private
    
    func setupUI() {
        navigationItem.title = "意见反馈"
        var  tempView = textView.superview
        tempView!.layer.cornerRadius = 10
        tempView!.layer.borderColor = UIColor.e5e5e5.cgColor
        tempView!.layer.borderWidth = onePixelWidth
        
        tempView = contactField.superview
        tempView!.layer.cornerRadius = 5
        tempView!.layer.borderColor = UIColor.e5e5e5.cgColor
        tempView!.layer.borderWidth = onePixelWidth
        
        textView.placeholder = "请简要描述你的问题与意见，请不要超过200个字符。"
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
