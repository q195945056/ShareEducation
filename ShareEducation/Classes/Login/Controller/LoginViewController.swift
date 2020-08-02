//
//  LoginViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/21.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    static var defalt: UIViewController = {
        let controller = LoginViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.interactivePopGestureRecognizer?.delegate = controller
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }()
    
    static func show(from viewController: UIViewController) {
        let loginViewController = LoginViewController.defalt
        viewController.present(loginViewController, animated: true, completion: nil)
    }
    
    lazy var logoImageView = UIImageView(image: UIImage(named: "logo_sign"))
    
    enum LoginType: Int {
        case validateCode = 1
        case password = 2
    }
    
    lazy var validateLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = LoginType.validateCode.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 21)
        button.setTitle("短信验证码登录", for: .normal)
        button.setTitleColor(.cdcdcd, for: .normal)
        button.setTitleColor(.darkTextColor, for: .selected)
        button.setTitleColor(.darkTextColor, for: [.selected, .highlighted])
        button.addTarget(self, action: #selector(onLoginTypeButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var passwordLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = LoginType.password.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 21)
        button.setTitle("密码登录", for: .normal)
        button.setTitleColor(.cdcdcd, for: .normal)
        button.setTitleColor(.darkTextColor, for: .selected)
        button.setTitleColor(.darkTextColor, for: [.selected, .highlighted])
        button.addTarget(self, action: #selector(onLoginTypeButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var currentController: BaseLoginViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        onLoginTypeButtonPressed(sender: validateLoginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private
    
    func setupUI() {
        view.backgroundColor = .white
        
        let closeButton = UIButton(title: "关闭", target: self, selector: #selector(onCloseButtonPressed(sender:)))
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(actualStatusBarHeight + 20);
            make.leading.equalTo(15)
        }
        
        view.addSubview(logoImageView)
        
        let containerView = UIView()
        containerView.addSubview(validateLoginButton)
        containerView.addSubview(passwordLoginButton)
        let line = UIView()
        line.backgroundColor = .cdcdcd
        containerView.addSubview(line)
        view.addSubview(containerView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(72)
            make.centerX.equalTo(view)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(50 + onePixelWidth)
            make.centerX.equalTo(view)
        }
        
        validateLoginButton.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(containerView)
        }
        
        line.snp.makeConstraints { (make) in
            make.leading.equalTo(validateLoginButton.snp.trailing).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(1)
            make.centerY.equalTo(containerView)
        }
        
        passwordLoginButton.snp.makeConstraints { (make) in
            make.leading.equalTo(line.snp.trailing).offset(20)
            make.trailing.equalTo(containerView)
            make.centerY.equalTo(containerView)
        }
        
    }
    
    // MARK: - Actions
    
    @objc func onCloseButtonPressed(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onLoginTypeButtonPressed(sender: UIButton) {
        for index in 1...2 {
            let button = sender.superview?.viewWithTag(index) as? UIButton
            button?.isSelected = false
        }
        sender.isSelected = true
        let loginType = LoginType(rawValue: sender.tag)!
        
        guard loginType != currentController?.loginType else {
            return
        }
        
        currentController?.willMove(toParent: nil)
        currentController?.view.removeFromSuperview()
        currentController?.removeFromParent()
        
        
        currentController = BaseLoginViewController.controllerWithLoginType(type: loginType)
        addChild(currentController!)
        view.addSubview(currentController!.view)
        currentController?.didMove(toParent: self)
        currentController?.view.snp.makeConstraints({ (make) in
            make.top.equalTo(passwordLoginButton.superview!.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        })
        
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

extension LoginViewController: UIGestureRecognizerDelegate {
}
