//
//  BaseLoginViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/21.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class BaseLoginViewController: UIViewController {
    
    static func controllerWithLoginType(type: LoginViewController.LoginType) -> BaseLoginViewController {
        switch type {
        case .validateCode:
            return ValidateCodeLoginViewController()
        case .password:
            return PasswordLoginViewController()
        }
    }
    
    var loginType: LoginViewController.LoginType? {
        nil
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom, backgroundImage: UIImage(named: "button_01"), title: "登录", target: self, selector: #selector(onLoginButtonPressed(sender:)))
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom, image: nil, backgroundImage: nil, title: "新用户注册", target: self, selector: #selector(onRegisterButtonPressed(sender:)))
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.e64919, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    @objc func onRegisterButtonPressed(sender: AnyObject) {
        let controller = RegisterViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func onLoginButtonPressed(sender: AnyObject) {
        guard valiteInput() else {
            return
        }
        
        login()
    }
    
    func login() {
        
    }
    
    func valiteInput() -> Bool {
        return false
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
