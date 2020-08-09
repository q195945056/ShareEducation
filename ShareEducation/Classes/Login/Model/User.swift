//
//  User.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/2.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import Cache
import SwiftyJSON
import ObjectMapper

class User: Codable {
    static let shared: User = {
        let config = DiskConfig(name: "Cache")
        let diskStorage = try? DiskStorage<User>(config: config, transformer: TransformerFactory.forCodable(ofType: User.self))
        var shared = try? diskStorage?.object(forKey: "User")
        if shared == nil {
            shared = User()
        }
        return shared!
    }()
    
    var isLogin = false {
        didSet {
            try? saveOnDisk()
            NotificationCenter.default.post(name: User.loginStatusDidChangeNotification, object: self)
        }
    }
    
    var userInfo: UserInfo?
    
    var account: String?
    
    var name: String? {
        set {
            userInfo?.name = newValue
        } get {
            return userInfo?.name
        }
    }
    
    var token: String? {
        return userInfo?.token
    }
    
    func setup(json: JSON) {
        let mapper = Mapper<UserInfo>()
        userInfo = mapper.map(JSONObject: json.object)
        isLogin = true
        if let userInfo = userInfo {
            let grade = ShareData.shared.findGrade(by: userInfo.gradeID)
            ShareSetting.shared.grade = grade
            
            let area = ShareData.shared.findArea(by: userInfo.areaID)
            ShareSetting.shared.area = area
        }
    }
    
    func saveOnDisk() throws {
        let config = DiskConfig(name: "Cache")
        let diskStorage = try DiskStorage<User>(config: config, transformer: TransformerFactory.forCodable(ofType: User.self))
        if isLogin {
            try diskStorage.setObject(self, forKey: "User")
        } else {
            try diskStorage.removeObject(forKey: "User")
        }
    }
    
    func logout() {
        userInfo = nil
        isLogin = false
    }
}

extension User {
    static let loginStatusDidChangeNotification = Notification.Name(rawValue: "loginStatusDidChangeNotification")
}

@objc enum MemberType: Int, Codable {
    case teacher = 1
    case student = 2
}

extension User {
    struct UserInfo: Codable, Mappable {
        var keyC: String!
        var ip: String!
        var firstTime: Date!
        var gradeID: Int!
        var memberType: MemberType!
        var areaID: Int!
        var token: String!
        var memberTypeName: String!
        var id: Int!
        var scheduling: String!
        var loginTime: Date!
        var name: String!
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            keyC <- map["key_c"]
            ip <- map["ip"]
            let dateTransform = CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss")
            firstTime <- (map["firstTime"], dateTransform)
            gradeID <- map["gradeid"]
            memberType <- map["memberTypeID"]
            areaID <- map["areaid"]
            token <- map["token"]
            memberTypeName <- map["memberTypeName"]
            id <- map["id"]
            scheduling <- map["scheduling"]
            loginTime <- (map["logintime"], dateTransform)
            name <- map["name"]
        }
    }
    

}
