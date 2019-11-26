//
//  Teacher.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper

class Teacher: Mappable {
    var mid: Int!
    var name: String?
    var trueName: String?
    var university: String?
    var title: String?
    var score: Int?
    var collect: Bool?
    var playCount: Int?
    var teachingAge: Int?
    var pic: String?
    var city: String?
    var schoolName: String?
    
    required init?(map: Map) {
         
    }
    
    func mapping(map: Map) {
        mid <- map["mid"]
        name <- map["name"]
        trueName <- map["truename"]
        university <- map["university"]
        title <- map["title"]
        score <- map["score"]
        collect <- map["collect"]
        playCount <- map["playcount"]
        teachingAge <- map["teachingage"]
        pic <- map["pic"]
        city <- map["city"]
        schoolName <- map["schoolname"]
    }
}
