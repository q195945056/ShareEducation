// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import ObjectMapper

// MARK: - Area
extension Area: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - Comment
extension Comment: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - Course
extension Course: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - Grade
extension Grade: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - GradeType
extension GradeType: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        grades <- map["grades"]
    }
}

// MARK: - InitData
extension InitData: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        key_c <- map["key_c"]
        scheduling <- map["scheduling"]
        areas <- map["areas"]
        courses <- map["courses"]
        gradetypes <- map["gradetypes"]
        resourcetypes <- map["resourcetypes"]
    }
}

// MARK: - ListResult
extension ListResult: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        data <- map["data"]
        result <- map["result"]
        total <- map["total"]
    }
}

// MARK: - Resource
extension Resource: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        img <- map["img"]
        linkUrl <- map["linkUrl"]
        parameter <- map["parameter"]
        title <- map["title"]
    }
}

// MARK: - Resourcetype
extension Resourcetype: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        resources <- map["resources"]
        type <- map["type"]
    }
}

// MARK: - Teacher
extension Teacher: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        mid <- map["mid"]
        name <- map["name"]
        truename <- map["truename"]
        university <- map["university"]
        title <- map["title"]
        score <- map["score"]
        collect <- map["collect"]
        playcount <- map["playcount"]
        teachingage <- map["teachingage"]
        pic <- map["pic"]
        city <- map["city"]
        schoolname <- map["schoolname"]
        totletime <- map["totletime"]
        course <- map["course"]
        grade <- map["grade"]
        teacherid <- map["teacherid"]
    }
}


