//
//  UIBundle+Info.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/13.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation

extension Bundle {
    static var appVersion: String? {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
