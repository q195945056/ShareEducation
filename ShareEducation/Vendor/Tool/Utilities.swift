//
//  Utilities.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/7/27.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import PKHUD

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
    
    static func toast(_ text: String, time: TimeInterval = 2) {
        HUD.flash(.label(text), delay: time)
    }
    
}
