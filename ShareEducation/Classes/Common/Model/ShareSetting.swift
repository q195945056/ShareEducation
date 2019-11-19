//
//  ShareSetting.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation

struct ShareSetting {
    static var shared = ShareSetting()
    
    var grade: Grade? {
        didSet {
            NotificationCenter.default.post(name: ShareSetting.gradeDidChangeNotification, object: grade)
        }
    }
    
    var area: Area?
    
    
}


extension ShareSetting {
    static let gradeDidChangeNotification = Notification.Name(rawValue: "gradeDidChangeNotification")
}
