//
//  Area.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper

struct Area: Mappable {
    var id: Int!
    var name: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
}

struct Course: Mappable {
    var id: Int!
    var name: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
}

struct Grade: Mappable {
    var id: Int!
    var name: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
}

struct Resource: Mappable {
    var id: Int!
    var img: String!
    var linkUrl: String!
    var parameter: String!
    var title: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id           <- map["id"]
        img          <- map["img"]
        linkUrl      <- map["linkUrl"]
        parameter    <- map["parameter"]
        title        <- map["title"]
    }
}

struct GradeType: Mappable {
    var id: Int!
    var name: String!
    var grades: [Grade]!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        grades  <- map["grades"]
    }
}

struct Resourcetype: Mappable {
    var id: Int!
    var name: String!
    var resources: [Resource]!
    var type: RType!
    
    enum RType: Int {
        case splash = 1
        case banner = 2
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        resources <- map["resources"]
        type <- map["type"]
    }
}

struct InitData: Mappable {
    var keyC: String!
    var scheduling: String!
    var areas: [String: [Area]]!
    var courses: [Course]!
    var gradetypes: [GradeType]!
    var resourcetypes: [Resourcetype]!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        keyC      <- map["key_c"]
        scheduling    <- map["scheduling"]
        areas  <- map["areas"]
        courses  <- map["courses"]
        gradetypes  <- map["gradetypes"]
        resourcetypes  <- map["resourcetypes"]
    }
}
