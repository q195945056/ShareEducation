//
//  Optional.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/21.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
