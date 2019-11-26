//
//  String+URLPrefix.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation



extension String {
    
    var baseURL: String {
        "http://xudp.cn:8181"
    }
    
    var fullURLString: String {
        return "\(baseURL)\(self)"
    }
}
