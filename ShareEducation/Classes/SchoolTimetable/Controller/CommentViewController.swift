//
//  CommentViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class CommentViewController: UIViewController {
    
    @IBOutlet var starRatingView: UIImageView!
    
    @IBOutlet var textView: RSKPlaceholderTextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        textView.placeholder = "请输入你的评价内容"
        
        let tempView = textView.superview
        tempView!.layer.borderColor = UIColor.dcdcdc.cgColor
        tempView!.layer.borderWidth = onePixelWidth
    }
    
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onConfirmButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
