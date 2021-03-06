//
//  PasswordLoginViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/21.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class PasswordLoginViewController: BaseLoginViewController {
    
    override var loginType: LoginViewController.LoginType? {
        get {
            return .password
        }
    }

    
    lazy var accountField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = UIColor(red:158, green: 166, blue: 178)
        textField.placeholder = "请输入用户名"
        textField.text = "13811111111"
        textField.font = .systemFont(ofSize: 13)
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = UIColor(red:158, green: 166, blue: 178)
        textField.placeholder = "请输入密码"
        textField.text = "123456"
        textField.font = .systemFont(ofSize: 13)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        let accountView = UIView()
        accountView.backgroundColor = .f5f5f5
        accountView.layer.cornerRadius = 20
        accountView.layer.masksToBounds = true
        view.addSubview(accountView)
        accountView.addSubview(accountField)
        
        let passwordView = UIView()
        passwordView.backgroundColor = .f5f5f5
        passwordView.layer.cornerRadius = 20
        passwordView.layer.masksToBounds = true
        view.addSubview(passwordView)
        passwordView.addSubview(passwordField)
        
        accountView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
            make.top.equalTo(view).offset(43)
            make.height.equalTo(40)
        }
        
        accountField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(accountView)
            make.leading.equalTo(accountView).offset(18)
            make.trailing.equalTo(accountView).offset(-18)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(accountView)
            make.top.equalTo(accountView.snp.bottom).offset(18)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(passwordView)
            make.leading.equalTo(passwordView).offset(18)
            make.trailing.equalTo(passwordView).offset(-18)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(passwordView)
            make.top.equalTo(passwordView.snp.bottom).offset(70)
        }
        
        let forgetPasswordButton = UIButton(type: .custom, image: nil, backgroundImage: nil, title: "忘记密码？", target: self, selector: #selector(onForgetPwdButtonPressed(sender:)))
        forgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 13)
        forgetPasswordButton.setTitleColor(.e64919, for: .normal)
        view.addSubview(forgetPasswordButton)
        
        forgetPasswordButton.snp.makeConstraints { (make) in
            make.leading.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(18)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(loginButton)
            make.top.equalTo(forgetPasswordButton)
        }
        
    }
    
    // MARK: - Actions
    
    override func login() {
        Utilities.showLoading(to: self.view!)
        serviceProvider.request(.login(name: accountField.text, password: passwordField.text?.md5String, type: "1", phone: nil, msgCode: nil)) { (result) in
            do {
                let json = try JSON(data: result.get().data)
                let status = json["result"].int
                if let status = status, status == 1 {
                    User.shared.account = self.accountField.text
                    User.shared.setup(json: json)
                    Utilities.showSuccess("登录成功", to: self.view)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    Utilities.showError("登录失败", to: self.view, animated: true)
                }
            } catch {
                Utilities.showError("登录失败", to: self.view, animated: true)
            }
        }
    }
    
    override func valiteInput() -> Bool {
        guard !accountField.text.isNilOrEmpty else {
            print("请输入帐号")
            return false
        }
                
        guard !passwordField.text.isNilOrEmpty else {
            print("请输入密码")
            return false
        }
        
        return true
    }
    
    @objc func onForgetPwdButtonPressed(sender: Any) {
        let controller = FindPwdViewController()
        navigationController?.pushViewController(controller, animated: true)
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
