//
//  CourseItem.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Moya

class CourseItem: Mappable {
    var id: Int!
    var name: String!
    var startTime: Date?
    var endTime: Date?
    var teacherID: Int?
    var teacherName: String?
    var teacherPic: String?
    var teacherTitle: String?
    var grade: String!
    var course: String!
    var schoolName: String?
    var price: Float?
    var buystate: BuyState!
    var buyCount: Int?
    var unitIds: Int?
    var state: PlayState?
    var pic: String?
    
    
    //课程详情
    var depict: String?
    var isCollect: Bool?
    var units: [CourseUnit]?
    var unitDepict: String?
    var unitID: Int?
        
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

extension CourseItem: Equatable {
    static func == (lhs: CourseItem, rhs: CourseItem) -> Bool {
        return lhs.id == rhs.id
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
    
    func setup(with detail: JSON) {
        let data = detail["data"]
        let unitcourses = data["unitcourses"]
        let mapper = Mapper<CourseUnit>()
        units = mapper.mapArray(JSONObject: unitcourses.object)
        units?.forEach({ (unit) in
            unit.state = state
        })
        isCollect = data["collectc"].boolValue
        unitID = data["unitid"].int
        if let value = data["buystate"].int {
            buystate = BuyState(rawValue: value)
        }
        if let value = data["price"].float {
            price = value
        }
        if let value = data["state"].int {
            state = PlayState(rawValue: value)
        }
        depict = data["depict"].string
        pic = data["pic"].string
        unitDepict = data["unitdepict"].string
        
        teacherID = data["teacher"]["id"].int
        teacherTitle = data["teacher"]["title"].string
        teacherPic = data["teacher"]["pic"].string
    }
    
    
    func collect(star: Bool, oper: Bool, completion:((_ success: Bool) -> Void)? = nil) {
        let user = User.shared
        guard user.isLogin else {
            return
        }
        serviceProvider.request(.collectCourse(id: id, star: star, oper: oper)) { result in
            let json = try? JSON(data: result.get().data)
            let status = json!["result"].int
            if let status = status, status == 1 {
                self.isCollect = oper
                if let completion = completion {
                    completion(true)
                }
            } else {
                if let completion = completion {
                    completion(false)
                }
            }
        }
    }
}

