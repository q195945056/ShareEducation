//
//  ListResult.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/20.
//  Copyright © 2019 严明俊. All rights reserved.
//

import ObjectMapper

final class ListResult<T: Mappable> {
    var data: [T]!
    var result: Int!
    var total: Int?
}

extension ListResult: AutoMappable {}
