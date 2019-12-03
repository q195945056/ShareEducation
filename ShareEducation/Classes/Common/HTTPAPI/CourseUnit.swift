//
//  CouseUnit.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper

class CourseUnit: Mappable {
    var id: Int!
    var name: String!
    var startTime: Date?
    var endTime: Date?
    var teacherName: String?
    var grade: String!
    var course: String!
    var schoolName: String?
    var price: Int?
    var buystate: CourseItem.BuyState!
    var state: CourseItem.PlayState!
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        let dateTransform = CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm")
        startTime <- (map["starttime"], dateTransform)
        endTime <- (map["endtime"], dateTransform)
        teacherName <- map["truename"]
        grade <- map["grade"]
        course <- map["course"]
        schoolName <- map["schoolname"]
        price <- map["Price"]
        if price == nil {
            price <- map["price"]
        }
        buystate <- map["buystate"]
    }
}
