//
//  ShareSetting.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation

class ShareSetting: Codable {
    static let shared: ShareSetting = {
        var shared: ShareSetting?
        do {
            let diskStorage = documentStorage.transformCodable(ofType: ShareSetting.self)
            shared = try diskStorage.object(forKey: "ShareSetting")
        } catch {
            shared = ShareSetting()
        }
        return shared!
    }()
    
    var grade: Grade = .default {
        didSet {
            NotificationCenter.default.post(name: ShareSetting.gradeDidChangeNotification, object: grade)
            try? saveOnDisk()
        }
    }
    
    var area: Area = .default {
        didSet {
            NotificationCenter.default.post(name: ShareSetting.areaDidChangeNotification, object: area)
            try? saveOnDisk()
        }
    }
    
    func saveOnDisk() throws {
        let diskStorage = documentStorage.transformCodable(ofType: ShareSetting.self)
        try! diskStorage.setObject(self, forKey: "ShareSetting")
    }
    
}


extension ShareSetting {
    static let gradeDidChangeNotification = Notification.Name(rawValue: "gradeDidChangeNotification")
    static let areaDidChangeNotification = Notification.Name(rawValue: "areaDidChangeNotification")
}
