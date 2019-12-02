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
    var teacherName: String?
    var teacherPic: String?
    var teacherTitle: String?
    var grade: String!
    var course: String!
    var schoolName: String?
    var price: Int?
    var buystate: BuyState!
    var buyCount: Int?
    var unitIds: Int?
    var state: PlayState?
    var pic: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        let dateTransform = CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm")
        startTime <- (map["starttime"], dateTransform)
        if startTime == nil {
            startTime <- (map["startTime"], dateTransform)
        }
        endTime <- (map["endtime"], dateTransform)
        if endTime == nil {
            endTime <- (map["endTime"], dateTransform)
        }
        teacherName <- map["truename"]
        teacherPic <- map["teacherpic"]
        teacherTitle <- map["title"]
        grade <- map["grade"]
        course <- map["course"]
        schoolName <- map["schoolname"]
        price <- map["Price"]
        if price == nil {
            price <- map["price"]
        }
        buystate <- map["buystate"]
        buyCount <- map["buycount"]
        unitIds <- map["unitids"]
        state <- map["state"]
        pic <- map["pic"]
    }
}

extension CourseItem {
    enum BuyState: Int {
        case free = 1
        case buy = 2
        case notBuy = 3
    }
    
    enum PlayState: Int {
        case notLiving = 1
        case living = 2
        case record = 3
    }
}

