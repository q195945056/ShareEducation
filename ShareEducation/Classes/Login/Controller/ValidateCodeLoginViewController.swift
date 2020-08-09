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
    
    override func login() {
        Utilities.showLoading()
        
        let phone = phoneField.text
        let code = validateCodeField.text
        
        User.login(type: .phone, phone: phone, msgCode: code) { (result) in
            switch result {
            case .success:
                Utilities.showSuccess("登录成功")
                self.dismiss(animated: true, completion: nil)
            case let .failure(error):
                Utilities.showError(error.errorDescription)
            }
        }
    }
    
    override func valiteInput() -> Bool {
        guard let phone = phoneField?.text, !phone.isEmpty else {
            Utilities.toast("请输入手机号")
            return false
        }
        
        guard Utilities.isTelNumber(num: phone) else {
            Utilities.toast("请输入正确的手机号")
            return false
        }
        
        guard let code = validateCodeField?.text, !code.isEmpty else {
            Utilities.toast("请输入验证码")
            return false
        }
        return true
    }
    
    @IBAction func onValidateCodeButtonPressed(sender: Any) {
        guard let phone = phoneField?.text, !phone.isEmpty else {
            Utilities.toast("请输入手机号")
            return
        }
        
        guard Utilities.isTelNumber(num: phone) else {
            Utilities.toast("请输入正确的手机号")
            return
        }
        
        User.sendSmsCode(to: phone, type: .login) { result in
            switch result {
            case .success:
                self.startTimer()
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
        
    }
    
    @IBOutlet var reSendButton: UIButton!
    
    var timer: Timer?
    
    var secondLeft = 60
    
    func startTimer() {
        secondLeft = 60
        let title = String(secondLeft)
        reSendButton.setTitle(title, for: .disabled)
        reSendButton.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimerTick(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        reSendButton.isEnabled = true
    }
    
    @objc func onTimerTick(_ timer: Timer) {
        secondLeft = secondLeft - 1
        if secondLeft > 0 {
            let title = String(secondLeft)
            reSendButton.setTitle(title, for: .disabled)
        } else {
            reSendButton.isEnabled = true
            timer.invalidate()
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
