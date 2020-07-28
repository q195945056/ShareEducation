//
//  RegisterViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/24.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly


class RegisterViewController: UIViewController {
        
    @IBOutlet var typeView: TypeView!
    
    @IBOutlet var areaField: UITextField?
    @IBOutlet var schoolNameField: UITextField?
    @IBOutlet var gradeField: UITextField?
    @IBOutlet var valueField: UITextField?
    @IBOutlet var nameField: UITextField?
    @IBOutlet var pinyinField: UITextField?
    @IBOutlet var pwdField: UITextField?
    @IBOutlet var repeatPwdField: UITextField?
    @IBOutlet var phoneField: UITextField?
    @IBOutlet var validateCodeField: UITextField?
    
    @IBOutlet var reSendButton: UIButton!
        
    @IBOutlet var agreeView: AgreeView!
    
    var areaID: Int?
    
    var gradeID: Int?
    
    var animator: Animator?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
    
    // MARK: - Actions
    
    @IBAction func onTypeButtonPressed(sender: TypeView) {
        if sender !== typeView {
            typeView?.isSelected = false
            sender.isSelected = true
            typeView = sender
            if typeView.type == 1 {
                valueField?.placeholder = "*教师资格证号"
            } else {
                valueField?.placeholder = "*学籍号"
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
    
    @IBAction func onValidateCodeButtonPressed(sender: Any) {
        guard let phone = phoneField?.text else {
            Utilities.toast("请输入手机号")
            return
        }
        
        guard Utilities.isTelNumber(num: phone) else {
            Utilities.toast("请输入正确的手机号")
            return
        }
        
        User.sendSmsCode(to: phone) { result in
            switch result {
            case .success:
                self.startTimer()
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
        
    }
    
    @IBAction func onAgreeButtonPressed(sender: AgreeView) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onRegisterButtonPressed(sender: Any) {
        guard let area = areaField?.text, !area.isEmpty else {
            Utilities.toast("请选择所在学校地区")
            return
        }
        guard let schoolName = schoolNameField?.text, !schoolName.isEmpty else {
            Utilities.toast("请填写学校名称")
            return
        }
        guard let grade = gradeField?.text, !grade.isEmpty else {
            Utilities.toast("请选择年级")
            return
        }
        guard let value = valueField?.text, !value.isEmpty else {
            if typeView?.type == 2 {
                Utilities.toast("请填写学籍号")
            } else {
                Utilities.toast("请填写教师资格证号")
            }
            return
        }
        guard let trueName = nameField?.text, !trueName.isEmpty else {
            Utilities.toast("请输入真实姓名")
            return
        }
        guard let pinyin = pinyinField?.text, !pinyin.isEmpty else {
            Utilities.toast("请输入姓名拼音全拼")
            return
        }
        guard let password = pwdField?.text, !password.isEmpty else {
            Utilities.toast("请输入密码")
            return
        }
        guard let repeatPassword = repeatPwdField?.text, !repeatPassword.isEmpty else {
            Utilities.toast("请重复输入密码")
            return
        }
        guard repeatPassword == password else {
            Utilities.toast("两次输入的密码不相同")
            return
        }
        guard let phone = phoneField?.text, !phone.isEmpty else {
            Utilities.toast("请输入手机号")
            return
        }
        
        guard Utilities.isTelNumber(num: phone) else {
            Utilities.toast("请输入正确的手机号")
            return
        }
        
        guard let code = validateCodeField?.text, !code.isEmpty else {
            Utilities.toast("请输入验证码")
            return
        }
        guard agreeView.isSelected else {
            Utilities.toast("您还未同意注册条款")
            return
        }
        
        
        User.register(userName: nil, password: password, memberType: String(typeView.type), areaID: String(areaID!), area: area, phone: phone, code: code, schoolName: schoolName, gradeID: String(gradeID!), schoolNum: value, trueName: trueName) { result in
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
                break
            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
    }
    
    @IBAction func onPrivacyButtonPressed(sender: Any) {
        
    }

    func onAreaButtonPressed() {
        let controller = AreaSettingViewController()
        controller.isRegister = true
        controller.didSelectArea = { area in
            self.areaField?.text = area.name
        }
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 260))
        let aligment = PresentationAlignment(vertical: .bottom, horizontal: .center)
        let uiConfiguration = PresentationUIConfiguration( backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = CoverPresentation(directionShow: .bottom, directionDismiss: .bottom, uiConfiguration: uiConfiguration, size: size, alignment: aligment, marginGuards: .zero)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        present(controller, animated: true)
    }
    
    func onGradeButtonPressed() {
        let controller = GradeSettingViewController()
        controller.didSelectGrade = { grade in
            self.gradeField?.text = grade.name
        }
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 370))
        let marginGuards = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 15, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        present(controller, animated: true)
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === areaField {
            onAreaButtonPressed()
            return false
        } else if textField === gradeField {
            onGradeButtonPressed()
            return false
        }
        return true
    }
}

class BorderView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 5
        layer.borderWidth = onePixelWidth
        layer.borderColor = UIColor.dcdcdc.cgColor
    }
}

@IBDesignable class TypeView: UIControl {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var markImageView: UIImageView?
    @IBInspectable var type: Int = 1
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel?.textColor = .black
                markImageView?.isHidden = false
            } else {
                titleLabel?.textColor = .lightTextColor
                markImageView?.isHidden = true
            }
        }
    }
}

class AgreeView: UIControl {
    @IBOutlet var imageView: UIImageView?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView?.image = UIImage(named: "icon_signsel2")
            } else {
                imageView?.image = UIImage(named: "icon_signsel")
            }
        }
    }
}
