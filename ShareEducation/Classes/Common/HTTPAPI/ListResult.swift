//
//  ListResult.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper

class ListResult<T: Mappable>: Mappable {
    var data: [T]!
    var result: Int!
    var total: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        result <- map["result"]
        total <- map["total"]
    }

}
