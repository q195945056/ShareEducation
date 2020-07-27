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
    static func sendSmsCode(to phone: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
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
    
    func register(userID: String? = nil, userName: String? = nil, password: String, memberType: String, areaID: String, area: String, phone: String, code: String, schoolName: String? = nil, gradeID: String, schoolNum: String, trueName: String, completion: @escaping (Result<Bool, SEError>) -> Void) {
//        serviceProvider.request(<#T##target: SEService##SEService#>, completion: <#T##Completion##Completion##(Result<Response, MoyaError>) -> Void#>)
    }
}
