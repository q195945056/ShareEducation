//
//  QaListItem.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/16.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper

struct QaListItem: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        content <- map["depict"]
        memberName <- map["memberName"]
        parentID <- map["parentID"]
    }
    
    var content: String!
    var id: Int!
    var memberName: String!
    var parentID: Int!
}
