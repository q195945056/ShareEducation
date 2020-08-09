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
    
    static func modifyPhone(phone: String, code: String, newPhone: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
        serviceProvider.request(.memberModifyPhone(phone: phone, code: code, newPhone: newPhone)) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    completion(.failure(.invalideResponse))
                    return
                }
                let result = responseData["result"].intValue
                guard result == 1 else {
                    let message: String
                    switch result {
                    case 0:
                        message = "未登录"
                    case 2:
                        message = "修改失败"
                    case 3:
                        message = "旧号码不存在"
                    case 4:
                        message = "新号码已经存在"
                    default:
                        message = "登录失败"
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
    
    static func modifyUserInfo(image: UIImage?, nickName: String, trueName: String, sex: Int, schoolNum: String, areaID: Int, schoolName: String, gradeID: Int, email: String, phone: String, completion: @escaping (Result<String?, SEError>) -> Void) {
        serviceProvider.request(.memberModify(img: image, trueName: trueName, nickName: nickName, sex: sex, email: email, schoolNum: schoolNum, gradeID: gradeID, areaID: areaID, schoolName: schoolName, phone: phone)) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    completion(.failure(.invalideResponse))
                    return
                }
                let result = responseData["result"].intValue
                guard result == 1 else {
                    completion(.failure(.invalideStatusCode(statusCode: result, message: "保存失败")))
                    Utilities.toast("保存失败")
                    return
                }
                
                let img = responseData["data"]["pic"].string
                completion(.success(img))
            case let .failure(error):
                completion(.failure(.moyaError(error: error)))
            }
        }
    }
    
    
    enum LoginType: String {
        case password = "1"
        case phone = "2"
    }
    
    static func login(type: LoginType, name: String? = nil, password: String? = nil, phone: String? = nil, msgCode: String? = nil, completion: @escaping (Result<Bool, SEError>) -> Void) {
        
        serviceProvider.request(.login(name: name, password: password?.md5String, type: type.rawValue, phone: phone, msgCode: msgCode)) { (result) in
            
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    completion(.failure(.invalideResponse))
                    return
                }
                let result = responseData["result"].intValue
                guard result == 1 else {
                    let message: String
                    switch result {
                    case 2:
                        message = "登录失败账号不存在"
                    case 3:
                        message = "参数错误"
                    case 4:
                        message = "地区限制"
                    case 5:
                        message = "用户已经导入没添加相关信息 弹出相关信息框给用户添加"
                    case 6:
                        message = "用户停用"
                    default:
                        message = "登录失败"
                    }
                    completion(.failure(.invalideStatusCode(statusCode: result, message: message)))
                    return
                }
                
                let data = responseData["data"]
                if let name = name {
                    User.shared.name = name
                }
                User.shared.setup(json: data)
                completion(.success(true))
            case let .failure(error):
                completion(.failure(.moyaError(error: error)))
            }
        }
    }
    
    enum ModifyPasswordType: Int {
        case modify
        case find
    }
    
    static func modifyPassword(type: ModifyPasswordType = .modify, phone: String?, code: String, password: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
        serviceProvider.request(.memberModifyPassword(code: code, password: password.md5String, type: type.rawValue, phone: phone)) { (result) in
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
    
    static func register(userID: String? = nil, userName: String, password: String, memberType: MemberType, areaID: String, area: String, phone: String, code: String, schoolName: String, gradeID: String, schoolNum: String, trueName: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
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
