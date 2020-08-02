//
//  Message.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/8/2.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper

class Message: Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        createTime <- map["createTime"]
        id <- map["id"]
        msgContent <- map["msgContent"]
        status <- map["status"]
        title <- map["title"]
        type <- map["type"]
        url <- map["url"]
    }
    
    var createTime: Date!
    var id: Int!
    var msgContent: String!
    var status: Int!
    var title: String!
    var type: Int!
    var url: String!
    
}
