//
//  WXApiManager.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/16.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaymentManager: NSObject, WXApiDelegate {
    
    static let `default` = PaymentManager()
    
    var completion: ((Result<Bool, SEError>) -> Void)?
    
    func payWechat(_ json: JSON, completion: @escaping (Result<Bool, SEError>) -> Void) {
        let data = json["data"]
        let partnerid = data["partnerid"].stringValue
        let prepay_id = data["prepay_id"].stringValue
        let package = "Sign=WXPay"
        let nonceStr = data["noncestr"].stringValue
        let timeStamp = data["timestamp"].stringValue
        let sign = data["sign"].stringValue
        
        self.completion = completion

        let request = PayReq()
        request.partnerId = partnerid
        request.prepayId = prepay_id
        request.package = package
        request.nonceStr = nonceStr
        request.timeStamp = UInt32(timeStamp) ?? 0
        request.sign = sign
        WXApi.send(request)
    }
    
    func payAli(_ json: JSON, completion: @escaping (Result<Bool, SEError>) -> Void) {
        self.completion = completion

        let data = json["data"]
        let alidata = data["alidata"].stringValue
        AlipaySDK.defaultService()?.payOrder(alidata, fromScheme: "netcoclass", callback: { resultDic in
            print(resultDic as Any)
        })
    }
    
    func onAlipayResult(_ resultDic: [AnyHashable : Any]?) {
        guard let resultDic = resultDic else {
            completion?(.failure(.invalideStatusCode(statusCode: -1, message: "支付失败")))
            return
        }
        guard let result = resultDic["result"] as? [String : Any] else {
            completion?(.failure(.invalideStatusCode(statusCode: -1, message: "支付失败")))
            return
        }
        if let code = result["code"] as? String, code == "10000" {
            self.completion?(.success(true))
        } else {
            completion?(.failure(.invalideStatusCode(statusCode: -1, message: "支付失败")))
        }
    }
    
    func onResp(_ resp: BaseResp!) {
        if let response = resp as? PayResp {
            switch response.errCode {
            case WXSuccess.rawValue:
                self.completion?(.success(true))
            case WXErrCodeUserCancel.rawValue:
                self.completion?(.failure(.userCanceled))
            default:
                self.completion?(.failure(.invalideStatusCode(statusCode: Int(response.errCode), message: "支付失败")))
            }
        }
    }
}
