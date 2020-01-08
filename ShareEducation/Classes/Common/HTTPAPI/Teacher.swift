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

final class Teacher {
    var mid: Int!
    var name: String?
    var truename: String?
    var university: String?
    var title: String?
    var score: Int?
    var collect: Bool?
    var playcount: Int?
    var teachingage: Int?
    var pic: String?
    var city: String?
    var schoolname: String?
    var totletime: Int?
    var course: String?
    var grade: String?
    var teacherid: Int!
}

extension Teacher: AutoMappable {}

extension Teacher {
    func setup(extraData: JSON) {
        grade = extraData["grade"].string
        teachingage = extraData["teachingage"].int
        title = extraData["title"].string
        score = extraData["score"].int
        teacherid = extraData["teacherid"].int
        truename = extraData["truename"].string
        pic = extraData["pic"].string
        course = extraData["course"].string
        city = extraData["city"].string
        collect = extraData["collect"].boolValue
        university = extraData["university"].string
        playcount = extraData["playcount"].int
        mid = extraData["mid"].int
        schoolname = extraData["schoolname"].string
        totletime = extraData["totletime"].int
    }
    
    func collect(oper: Bool, completion: @escaping (_ success: Bool) -> Void) {
        let user = User.shared
        guard user.isLogin else {
            return
        }
        serviceProvider.request(.collectTeacher(name: user.account!, token: user.token!, id: teacherid, oper: oper)) { result in
            let json = try? JSON(data: result.get().data)
            let status = json!["result"].int
            if status == 1 {
                self.collect = oper
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
