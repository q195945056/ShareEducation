//
//  ValidateCodeLoginViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/21.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class ValidateCodeLoginViewController: BaseLoginViewController {
    
    @IBOutlet var validateCodeView: UIView!
    
    @IBOutlet var phoneField: UITextField!
    
    @IBOutlet var validateCodeField: UITextField!
    
    override var loginType: LoginViewController.LoginType? {
        get {
            return .validateCode
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        loginButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(validateCodeView)
            make.top.equalTo(validateCodeView.snp.bottom).offset(70)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(18)
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
