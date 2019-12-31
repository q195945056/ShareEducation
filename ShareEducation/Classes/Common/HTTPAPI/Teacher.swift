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
}

extension Teacher: AutoMappable {}

extension Teacher {
    func setup(extraData: JSON) {
        totletime = extraData["totletime"].int
    }
    
    func collect(oper: Bool, completion: @escaping (_ success: Bool) -> Void) {
        let user = User.shared
        guard user.isLogin else {
            return
        }
        serviceProvider.request(.collectTeacher(name: user.account!, token: user.token!, id: mid, oper: oper)) { result in
            let json = try? JSON(data: result.get().data)
            let status = json!["result"].int
            if let status = status, status == 1 {
                self.collect = oper
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
