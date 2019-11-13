//
//  SEService.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/13.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Moya

enum SEService {
    case initData
    case login(name: String?, password: String?, type: String?, phone: String?, msgCode: String?)
}

extension SEService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.myservice.com")!
    }
    
    var path: String {
        switch self {
        case .initData:
            return "/education/api/member_login.action"
        case .login(_, _, _, _, _):
            return "/education/api/member_sendsms.action"
        }
    }
    
    var method: Method {
        switch self {
        case .initData, .login(_, _, _, _, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .initData:
            return .requestPlain
        case .login(let name, let password, let type, let phone, let msgCode): do {
            var parameters = [String : Any]()
            parameters["name"] = name
            parameters["password"] = password
            parameters["type"] = type
            parameters["phone"] = phone
            parameters["msgCode"] = msgCode
            parameters["appver"] = Bundle.appVersion
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
