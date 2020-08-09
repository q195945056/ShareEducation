//
//  FindPwdViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/24.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class FindPwdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "找回密码"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    var type: User.ModifyPasswordType = .modify
    
    @IBOutlet var phoneField: UITextField!
    
    @IBOutlet var codeField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var reSendButton: UIButton!
    
    @IBAction func onConfirmButtonPressed(_ sender: Any) {
        guard let phone = phoneField?.text else {
            Utilities.toast("请输入手机号")
            return
        }
        guard let code = codeField?.text else {
            Utilities.toast("请输验证码")
            return
        }
        guard let password = passwordField?.text else {
            Utilities.toast("请输入新密码")
            return
        }
        
        User.modifyPassword(type: type, phone: phone, code: code, password: password) { (result) in
            switch result {
            case .success:
                Utilities.toast("修改成功")
                self.navigationController?.popViewController(animated: true)
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
        
    }
    
    @IBAction func onValidateCodeButtonPressed(sender: Any) {
        guard let phone = phoneField?.text else {
            Utilities.toast("请输入手机号")
            return
        }
        
        guard Utilities.isTelNumber(num: phone) else {
            Utilities.toast("请输入正确的手机号")
            return
        }
        
        User.sendSmsCode(to: phone, type: .password) { result in
            switch result {
            case .success:
                self.startTimer()
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
        
    }
    
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
