//
//  Comment.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/27.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper

struct Comment {
    var id: Int!
    var name: String!
}

extension Comment: AutoMappable {}
