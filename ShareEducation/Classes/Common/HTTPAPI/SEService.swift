//
//  SEService.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/13.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import Foundation
import Moya

let serviceProvider = MoyaProvider<SEService>()

enum SEService {
    case initData
    case login(name: String?, password: String?, type: String?, phone: String?, msgCode: String?)
    case sendSMS(phone: String)
    case getCourseList(type: String?, dateType: String, date: String, name: String?, token: String?, offset: String, rows:String, areaid: String?, courseid: String?, gradeid: String?)
    case getCourseDetail(name: String?, token: String?, id: String)
    case courseBuy(name: String, token: String, id: String)
    case getTeacherTopList(name: String?, token: String?, rows: String, areaid: String?, courseid: String?, gradeid: String?)
    case getTeacherList(name: String?, token: String?, offset: String, rows: String, areaid: String?, courseid: String?, gradeid: String?)
    case getTeacherDetail(name: String?, token: String?, id: String)
}

extension SEService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://xudp.cn:8181")!
    }
    
    var path: String {
        switch self {
        case .initData:
            return "/education/resource/sysdata/initdata.json"
        case .login:
            return "/education/api/member_login.action"
        case .sendSMS:
            return "/education/api/member_sendsms.action"
        case .getCourseList:
            return "/education/api/course_list.action"
        case .getCourseDetail:
            return "/education/api/course_detail.action"
        case .courseBuy:
            return "/education/api/course_buy.action"
        case .getTeacherTopList:
            return "/education/api/teacher_toplist.action"
        case .getTeacherList:
            return "/education/api/teacher_list.action"
        case .getTeacherDetail:
            return "/education/api/teacher_detail.action"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .initData:
            return .requestPlain
        case .login(let name, let password, let type, let phone, let msgCode):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.password"] = password
            parameters["m.type"] = type
            parameters["m.phone"] = phone
            parameters["m.msgCode"] = msgCode
            parameters["m.appver"] = Bundle.appVersion
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .sendSMS(let phone):
            return .requestParameters(parameters: ["m.phone": phone], encoding: URLEncoding.queryString)
        case .getCourseList(let type, let dateType, let date, let name, let token, let offset, let rows, let areaid, let courseid, let gradeid):
            var parameters = [String : Any]()
            parameters["c.type"] = type
            parameters["c.datetype"] = dateType
            parameters["c.date"] = date
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["offset"] = offset
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid ?? "0"
            parameters["m.courseid"] = courseid ?? "0"
            parameters["m.gradeid"] = gradeid ?? "0"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getCourseDetail(let name, let token, let id):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["c.id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseBuy(let name, let token, let id):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["c.id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherTopList(let name, let token, let rows, let areaid, let courseid, let gradeid):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid ?? "0"
            parameters["m.courseid"] = courseid ?? "0"
            parameters["m.gradeid"] = gradeid ?? "0"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherList(let name, let token, let offset, let rows, let areaid, let courseid, let gradeid):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["offset"] = offset
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid ?? "0"
            parameters["m.courseid"] = courseid ?? "0"
            parameters["m.gradeid"] = gradeid ?? "0"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherDetail(let name, let token, let id):
            var parameters = [String : Any]()
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["t.mid"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
        
//        var string: String!
//        switch self {
//        case .initData:
//            string = """
//{
//    "key_c": "tJgIf0zJXw/8TFPh0xKqj4Rqpscg7M1a9+uZdh/naJLGuftsf9VsvL08n1BG3uYsTS+5eNGMcgjXAchJmxocfDRDMsUnhfr9BUOyTDgar0DfpwmSbp+7SDupVqCpEuaLgnjNNlOrIwzQ034sNrxbJsKiJRC7WK0U1Lf/RhkxH8iLu2ifm0OlJczyxrXnlHvqRHjXZD9d8C8ja1v/2/qzvoCEStChheDyX84QpX1kmNFpfa4I/OaKuuLKQipJc9u+O60Hbpl/Rvfg0Z6NafjyhoutZ4hif937eHUPgx7YXjdlpkyu8sAKlYV3ugmZGvy8SA3MM1zEG2BOCzA1/WQFoQ==",
//    "scheduling": "54.39.105.19:9560/[2607:5300:203:3b13::]:9560;"
//    "areas": {
//        "山东省": [
//            {
//                "id": 1,
//                "name": "潍坊市"
//            },
//            {
//                "id": 2,
//                "name": "烟台市"
//            }
//        ]
//    },
//    "courses": [
//        {
//            "id": 1,
//            "name": "语文"
//        },
//        {
//            "id": 2,
//            "name": "数学"
//        }
//    ],
//    "gradetypes": [
//        {
//            "grades": [
//                {
//                    "id": 1,
//                    "name": "一年级"
//                },
//                {
//                    "id": 2,
//                    "name": "二年级"
//                }
//            ],
//            "id": 1,
//            "name": "小学阶段"
//        },
//        {
//            "grades": [
//                {
//                    "id": 3,
//                    "name": "初一"
//                },
//                {
//                    "id": 4,
//                    "name": "初二"
//                },
//                {
//                    "id": 5,
//                    "name": "初三"
//                }
//            ],
//            "id": 2,
//            "name": "初中阶段"
//        }
//    ],
//    "resourcetypes": [
//        {
//            "id": 1,
//            "name": "loading",
//            "resources": [
//                {
//                    "id": 2,
//                    "img": "/resource/img/resources/20191028/1572230060272.png",
//                    "linkUrl": "http://www.baidu.com",
//                    "parameter": "",
//                    "title": "bg1"
//                }
//            ],
//            "type": 1
//        },
//        {
//            "id": 2,
//            "name": "banner",
//            "resources": [
//                {
//                    "id": 4,
//                    "img": "/resource/img/resources/20191028/1572230223722.jpg",
//                    "linkUrl": "http://www.baidu.com",
//                    "parameter": "",
//                    "title": "tp2"
//                },
//                {
//                    "id": 3,
//                    "img": "/resource/img/resources/20191028/1572230139954.png",
//                    "linkUrl": "",
//                    "parameter": "",
//                    "title": "tp1"
//                }
//            ],
//            "type": 2
//        }
//    ]
//}
//"""
//        case .login(_, _, _, _, _):
//            string = """
//{
//    "data": {
//        "areaid": 0,
//        "firstTime": "2019-11-06T12:28:33",
//        "gradeid": 0,
//        "id": 1,
//        "ip": "127.0.0.1",
//        "key_c": "KvP34PwBjXGp60T5Z3/o0OXNsUvptWrmXhycV5mye2INGk9uKCsuNagk2YupCDVS1wlej+RywaoW0lhGNyAusu0REQ1bvVMjM1HjGGWB97GfP6Qh/kYwM1SfUekPwnnagnuwjKHqIQe9biy+1w+5Qt4SIhrs5Pbqhj2Pxnh8jeSKkbUxYt3t/OEZNEdPokf+JoMbR5ma26wIgIZmyS/0afrDyvUDCwFJUeTZ1omFrfRAhFINn4xEvg6jmXiIgnV7pM0e95cQJqeDZkNEammCjPwzNi2E5AC2YwA1IaSq3Xw96PGsN+Lp0vi/ql/0w3xUQuaJA0JPa8MsQBc0rpukUw==",
//        "logintime": "2019-11-06T12:28:33",
//        "memberTypeID": 1,
//        "memberTypeName": "教师",
//        "name": "wang",
//   "trueName": "王老师",
//     "scheduling": "54.39.105.19:9560/[2607:5300:203:3b13::]:9560;",
//        "token": "LQsYOS"
//    },
//    "result": 1
//}
//"""
//        case .sendSMS(_):
//            string = """
//{
//  "result": 1,
//  "data": "短信内容"
//}
//"""
//        }
//        return string.data(using: String.Encoding.utf8)!
    }
    
}
