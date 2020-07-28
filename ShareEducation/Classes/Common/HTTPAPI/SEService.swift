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

enum SEError: Error {
    case invalideResponse
    case invalideStatusCode(statusCode: Int, message: String)
    case userCanceled
    case systemError(error: Error)
    case platformError(error: Error)
    case moyaError(error: MoyaError)
    
    var errorDescription: String {
        switch self {
        case .invalideResponse:
            return "数据格式错误"
        case let .invalideStatusCode(_, message):
            return message
        case .userCanceled:
            return "用户主动取消"
        case let .platformError(error), let .systemError(error):
            return error.localizedDescription
        case let .moyaError(error):
            return error.errorDescription ?? "网络错误"
        }
    }
}

enum CoursePlayType: Int {
    case living = 1
    case record = 2
}

enum SEService {
    case initData
    case login(name: String?, password: String?, type: String?, phone: String?, msgCode: String?)
    case memberRegister(id: String?, password: String, memberTypeID: String, areaID: String, area: String, phone: String, code: String, schoolName: String, gradeID: String, schoolNum: String, trueName: String)
    case sendSMS(phone: String)
    case getCourseList(type: CoursePlayType, dateType: String, date: String, name: String?, token: String?, offset: Int, rows:Int, areaid: Int, courseid: Int, gradeid: Int)
    case getCourseDetail(name: String?, token: String?, id: Int)
    case courseBuy(name: String, token: String, id: Int)
    case getTeacherTopList(rows: Int, areaid: Int, courseid: Int, gradeid: Int)
    case getTeacherList(name: String?, token: String?, offset: Int, rows: Int, areaid: Int, courseid: Int, gradeid: Int, sort: Int = 0)
    case getTeacherDetail(name: String?, token: String?, id: Int)
    case collectTeacher(name: String?, token: String?, id: Int, oper: Bool)
    case playCourse(name: String?, token: String?, id: Int)
    case collectCourse(name: String?, token: String?, id: Int, star: Bool, oper: Bool)
    case courseScore(cid: String, tid: String, score: String, depict: String)
    case coursePlayLog(cid: String, tid: String)
    case teacherMyCollect
    case courseMyList
    case courseOrder(ids: String, terminal: String)
    case courseSearchOrder(orderID: String)
    case sysFaqList
    case sysMyMsgList
    case courseQaList(courseID: String)
    case courseQa(img: [UIImage]?, cid: String, parentID: String, content: String)
    case memberSendSmsReg(phone: String)
    case sysOpinion(content: String, contacts: String?, img: UIImage?)
}

extension SEService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://www.netcoclass.com:8080")!
    }
    
    var path: String {
        switch self {
        case .initData:
            return "/education/resource/sysdata/initdata.json"
        case .login:
            return "/education/api/member_login.action"
        case .memberRegister:
            return "/education/api/member_register.action"
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
        case .collectTeacher:
            return "/education/api/teacher_collect.action"
        case .playCourse:
            return "/education/api/course_play.action"
        case .collectCourse:
            return "/education/api/course_collectc.action"
        case .courseScore:
            return "/education/api/course_score.action"
        case .coursePlayLog:
            return "/education/api/course_playlog.action"
        case .teacherMyCollect:
            return "/education/api/teacher_mycollect.action"
        case .courseMyList:
            return "/education/api/course_mylist.action"
        case .courseOrder:
            return "/education/api/course_order.action"
        case .courseSearchOrder:
            return "/education/api/course_searchorder.action"
        case .sysFaqList:
            return "/education/api/sys_faqlist.action"
        case .sysMyMsgList:
            return "/education/api/sys_mymsglist.action"
        case .courseQaList:
            return "/education/api/course_qalist.action"
        case .courseQa:
            return "/education/api/course_qa.action"
        case .memberSendSmsReg:
            return "/education/api/member_sendsmsreg.action"
        case .sysOpinion:
            return "/education/api/sys_opinion.action"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters = [String : Any]()

        switch self {
        case .initData:
            return .requestPlain
        case .login(let name, let password, let type, let phone, let msgCode):
            parameters["m.name"] = name
            parameters["m.password"] = password
            parameters["m.type"] = type
            parameters["m.phone"] = phone
            parameters["m.msgCode"] = msgCode
            parameters["m.appver"] = Bundle.appVersion
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .memberRegister(let id, let password, let memberTypeID, let areaID, let area, let phone, let code, let schoolName, let gradeID, let schoolNum, let trueName):
            parameters["m.id"] = id
            parameters["m.name"] = User.shared.name
            parameters["m.password"] = password
            parameters["m.membertypeid"] = memberTypeID
            parameters["m.areaid"] = areaID
            parameters["m.area"] = area
            parameters["m.phone"] = phone
            parameters["m.code"] = code
            parameters["m.schoolname"] = schoolName
            parameters["m.gradeid"] = gradeID
            parameters["m.schoolnum"] = schoolNum
            parameters["m.truename"] = trueName
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .sendSMS(let phone):
            return .requestParameters(parameters: ["m.phone": phone], encoding: URLEncoding.queryString)
        case .getCourseList(let type, let dateType, let date, let name, let token, let offset, let rows, let areaid, let courseid, let gradeid):
            parameters["c.type"] = type.rawValue
            parameters["c.datetype"] = dateType
            parameters["c.date"] = date
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["offset"] = offset
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid
            parameters["m.courseid"] = courseid
            parameters["m.gradeid"] = gradeid
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getCourseDetail(let name, let token, let id):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["c.id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseBuy(let name, let token, let id):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["c.id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherTopList(let rows, let areaid, let courseid, let gradeid):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid
            parameters["m.courseid"] = courseid
            parameters["m.gradeid"] = gradeid
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherList(let name, let token, let offset, let rows, let areaid, let courseid, let gradeid, let sort):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["offset"] = offset
            parameters["rows"] = rows
            parameters["m.areaid"] = areaid
            parameters["m.courseid"] = courseid
            parameters["m.gradeid"] = gradeid
            parameters["m.sort"] = sort
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getTeacherDetail(let name, let token, let id):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["t.mid"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .collectTeacher(let name, let token, let id, let oper):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["t.id"] = id
            parameters["t.oper"] = oper ? 1 : 0
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .playCourse(let name, let token, let id):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["c.id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .collectCourse(let name, let token, let id, let star, let oper):
            parameters["m.name"] = name
            parameters["m.token"] = token
            parameters["t.id"] = id
            parameters["c.star"] = star ? 1 : 0
            parameters["t.oper"] = oper ? 1 : 0
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseScore(let cid, let tid, let score, let depict):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["s.cid"] = cid
            parameters["s.tid"] = tid
            parameters["s.score"] = score
            parameters["s.depict"] = depict
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case.coursePlayLog(let cid, let tid):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["p.cid"] = cid
            parameters["p.tid"] = tid
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .teacherMyCollect:
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            return .requestPlain
        case .courseMyList:
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            return .requestPlain
        case .courseOrder(let ids, let terminal):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["c.ids"] = ids
            parameters["c.terminal"] = terminal
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseSearchOrder(let orderID):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["c.orderid"] = orderID
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .sysFaqList:
            return .requestPlain
        case .sysMyMsgList:
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseQaList(let courseID):
            parameters["m.name"] = User.shared.name
            parameters["m.token"] = User.shared.token
            parameters["c.id"] = courseID
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .courseQa(let img,let cid, let parentID, let content):
            parameters["img"] = img
            parameters["name"] = User.shared.name
            parameters["token"] = User.shared.token
            parameters["cid"] = cid
            parameters["parentID"] = parentID
            parameters["content"] = content
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .memberSendSmsReg(let phone):
            parameters["m.phone"] = phone
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .sysOpinion(let content, let contacts, let img):
            parameters["name"] = User.shared.name
            parameters["content"] = content
            parameters["contacts"] = contacts
            parameters["img"] = img
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
