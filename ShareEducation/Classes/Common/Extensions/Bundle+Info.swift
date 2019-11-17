//
//  UIBundle+Info.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/13.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import Foundation

extension Bundle {
    static var appVersion: String? {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
