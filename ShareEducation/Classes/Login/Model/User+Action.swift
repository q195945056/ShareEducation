//
//  User+Action.swift
//  ShareEducation
//
//  Created by 严明俊 on 2020/7/27.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import SwiftyJSON

extension User {
    
    enum ModifyPasswordType: Int {
        case modify
        case find
    }
    
    static func modifyPassword(type: ModifyPasswordType = .modify, phone: String?, code: String, password: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
        serviceProvider.request(.memberModifyPassword(code: code, password: password, type: type.rawValue, phone: phone)) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    completion(.failure(.invalideResponse))
                    return
                }
                
                let result = responseData["result"].intValue
                guard result == 1 else {
                    var message = "未知错误"
                    if result == 0 {
                        message = "未登录"
                    } else if result == 2 {
                        message = "修改失败"
                    } else if result == 3 {
                        message = "手机号不存在"
                    }
                    completion(.failure(.invalideStatusCode(statusCode: result, message: message)))
                    return
                }
                
                completion(.success(true))
            case let .failure(error):
                completion(.failure(.moyaError(error: error)))
            }
        }
    }
    
    enum SmsCodeType {
        case login
        case register
        case password
    }
    
    static func sendSmsCode(to phone: String, type: SmsCodeType = .login, completion: @escaping (Result<Bool, SEError>) -> Void) {
        
        if type == .login {
            serviceProvider.request(.memberSendSmsReg(phone: phone)) { (result) in
                switch result {
                case let .success(response):
                    guard let responseData = try? JSON(data: response.data) else {
                        completion(.failure(.invalideResponse))
                        return
                    }
                    
                    let result = responseData["result"].intValue
                    guard result == 1 else {
                        completion(.failure(.invalideStatusCode(statusCode: result, message: "发送验证码失败")))
                        return
                    }
                    
                    completion(.success(true))
                    break
                case let .failure(error):
                    completion(.failure(.moyaError(error: error)))
                }
            }
        } else {
            serviceProvider.request(.memberSendSmsReg(phone: phone)) { (result) in
                switch result {
                case let .success(response):
                    guard let responseData = try? JSON(data: response.data) else {
                        completion(.failure(.invalideResponse))
                        return
                    }
                    
                    let result = responseData["result"].intValue
                    guard result == 1 else {
                        completion(.failure(.invalideStatusCode(statusCode: result, message: "发送验证码失败")))
                        return
                    }
                    
                    completion(.success(true))
                    break
                case let .failure(error):
                    completion(.failure(.moyaError(error: error)))
                }
            }
        }
        
        
        
    }
    
    static func register(userID: String? = nil, userName: String, password: String, memberType: String, areaID: String, area: String, phone: String, code: String, schoolName: String, gradeID: String, schoolNum: String, trueName: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
        serviceProvider.request(.memberRegister(id: userID, name: userName, password: password, memberTypeID: memberType, areaID: areaID, area: area, phone: phone, code: code, schoolName: schoolName, gradeID: gradeID, schoolNum: schoolNum, trueName: trueName)) { result in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    completion(.failure(.invalideResponse))
                    return
                }
                
                let result = responseData["result"].intValue
                guard result == 1 else {
                    var message = "未知错误"
                    if result == 2 {
                        message = "注册失败"
                    } else if result == 3 {
                        message = "用户名已经存在"
                    } else if result == 4 {
                        message = "手机号已经存在"
                    }
                    completion(.failure(.invalideStatusCode(statusCode: result, message: message)))
                    return
                }
                
                completion(.success(true))
            case let .failure(error):
                completion(.failure(.moyaError(error: error)))
            }
        }
    }
}
