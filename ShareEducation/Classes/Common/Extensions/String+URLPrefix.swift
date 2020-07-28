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
        "http://www.netcoclass.com:8080"
    }
    
    var fullURLString: String {
        return "http://www.netcoclass.com:8080/education\(self)"
    }
}
