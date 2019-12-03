//
//  Teacher.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class Teacher: Mappable {
    var mid: Int!
    var name: String?
    var trueName: String?
    var university: String?
    var title: String?
    var score: Int?
    var isCollect: Bool?
    var playCount: Int?
    var teachingAge: Int?
    var pic: String?
    var city: String?
    var schoolName: String?
    var totletime: Int?
    
    required init?(map: Map) {
         
    }
    
    func mapping(map: Map) {
        mid <- map["mid"]
        name <- map["name"]
        trueName <- map["truename"]
        university <- map["university"]
        title <- map["title"]
        score <- map["score"]
        isCollect <- map["collect"]
        playCount <- map["playcount"]
        teachingAge <- map["teachingage"]
        pic <- map["pic"]
        city <- map["city"]
        schoolName <- map["schoolname"]
        
        #if DEBUG
        score = 5
        playCount = 123
        #endif
    }
}

extension Teacher {
    func setup(extraData: JSON) {
        totletime = extraData["totletime"].int
    }
    
    func collect(oper: Bool, completion: @escaping (_ success: Bool) -> Void) {
        let user = User.shared
        guard user.isLogin else {
            return
        }
        serviceProvider.request(.collectTeacher(name: user.name!, token: user.token!, id: mid, oper: oper)) { result in
            let json = try? JSON(data: result.get().data)
            let status = json!["result"].int
            if let status = status, status == 1 {
                self.isCollect = oper
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
