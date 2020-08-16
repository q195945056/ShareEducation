//
//  WXApiManager.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/16.
//  Copyright © 2020 严明俊. All rights reserved.
//

import Foundation
import SwiftyJSON

class WXApiManager: NSObject, WXApiDelegate {
    
    static let `default` = WXApiManager()
    
    var completion: ((Result<Bool, SEError>) -> Void)?
    
    func pay(_ json: JSON, completion: @escaping (Result<Bool, SEError>) -> Void) {
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
