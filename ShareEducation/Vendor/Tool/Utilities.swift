//
//  Utilities.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/7/27.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import MBProgressHUD

class Utilities {
    static func isTelNumber(num: String) -> Bool {
        let mobile = "^1[3-9]\\d{9}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true)) {
            return true
        } else {
            return false
        }
    }
    
    static func toast(_ text: String, in view: UIView? = nil, offset: Float = 0, hideAfter delay: TimeInterval = 2) {
        guard !text.isEmpty else {
            return
        }
        
        var superView = view
        if superView == nil {
            superView = UIApplication.shared.keyWindow!
        }
        
        let hud = MBProgressHUD.showAdded(to: superView!, animated: true)
        hud.mode = .text
        hud.isUserInteractionEnabled = false
        hud.margin = 15.0
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: delay)
    }
    
    static func showLoading(to view: UIView, animated: Bool = true) {
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    static func showSuccess(_ message: String? = nil, to view: UIView, animated: Bool = true) {
        var hud = MBProgressHUD.forView(view)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: view, animated: animated)
        }
        hud?.mode = .customView
        let image = UIImage(named: "Checkmark")?.withRenderingMode(.alwaysTemplate)
        hud?.customView = UIImageView(image: image)
        hud?.isSquare = true
        hud?.label.text = message ?? "成功"
        hud?.hide(animated: animated, afterDelay: 2)
    }
    
    static func showError(_ message: String? = nil, to view: UIView, animated: Bool = true) {
        var hud = MBProgressHUD.forView(view)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: view, animated: animated)
        }
        hud?.mode = .customView
        let image = UIImage(named: "Checkmark")?.withRenderingMode(.alwaysTemplate)
        hud?.customView = UIImageView(image: image)
        hud?.isSquare = true
        hud?.label.text = message ?? "失败"
        hud?.hide(animated: animated, afterDelay: 2)
    }
    
}
