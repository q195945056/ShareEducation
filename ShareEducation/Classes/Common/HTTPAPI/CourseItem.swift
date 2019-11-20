//
//  CourseItem.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper

class CourseItem: Mappable {
    var id: Int!
    var name: String!
    var startTime: Date?
    var endTime: Date?
    var trueName: String!
    var grade: String!
    var course: String!
    var schoolName: String!
    var price: Int!
    var buystate: BuyState!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        let dateTransform = CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm")
        startTime <- (map["starttime"], dateTransform)
        endTime <- (map["endtime"], dateTransform)
        trueName <- map["truename"]
        grade <- map["grade"]
        course <- map["course"]
        schoolName <- map["schoolname"]
        price <- map["Price"]
        buystate <- map["buystate"]
    }
}

enum BuyState: Int {
    case free = 1
    case buy = 2
    case notBuy = 3
}
