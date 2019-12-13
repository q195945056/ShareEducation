//
//  Area.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import ObjectMapper

protocol AutoMappable {}
protocol AutoEquatable {}

struct Area: Codable {
    var id: Int!
    var name: String!
    static let `default` = Area(id: 0, name: "不限")
}

extension Area: AutoMappable {}

struct Course: Codable {
    var id: Int!
    var name: String!
    static let `default` = Course(id: 0, name: "全部")
}

extension Course: AutoMappable {}

struct Grade: Codable {
    var id: Int!
    var name: String!
    static let `default` = Grade(id: 0, name: "全部")
}

extension Grade: AutoEquatable, AutoMappable {}

struct Resource: Codable {
    var id: Int!
    var img: String!
    var linkUrl: String!
    var parameter: String!
    var title: String!
}

extension Resource: AutoMappable {}

struct GradeType: Codable {
    var id: Int!
    var name: String!
    var grades: [Grade]!
}

extension GradeType: AutoMappable {}

struct Resourcetype: Codable {
    var id: Int!
    var name: String!
    var resources: [Resource]!
    var type: RType!
    
    enum RType: Int, Codable {
        case splash = 1
        case banner = 2
    }
}

extension Resourcetype: AutoMappable {}

struct InitData {
    var key_c: String!
    var scheduling: String!
    var areas: [String: [Area]]!
    var courses: [Course]!
    var gradetypes: [GradeType]!
    var resourcetypes: [Resourcetype]!
}

extension InitData: AutoMappable {}
