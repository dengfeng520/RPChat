//
//  RPAuthRemoteAPI.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON
import RxSwift

public struct RPAuthRemoteAPI: AuthRemoteProtocol {
    /// 调用接口，成功返回JSON -----> PromiseKit
    public func post(with body: [String : AnyObject], _ path: String) -> Promise<JSON> {
        let headers: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded",
                                    "version" : "318",
                                    "token" : "8f814260-e93b-4e4b-b6b5-812a3103f3b1",
                                    "appId" : "e2766ff90db544ab9b3c7eaa8b834120",
                                    "type" : "1",
                                    "channel" : "iOS"]
        // body
        var parameters = Encryption.dictWithParamerters(maps: body)
        parameters.removeValue(forKey: "appSecret")
        parameters.removeValue(forKey: "appIdr")
        
        return Promise<JSON> { seal in
            AF.request(path, method: .post, parameters: parameters, headers: headers).response { response in
                if let data = response.data ,let responseCode = response.response {
                    do {
                        let json = try JSON(data: data)
                        switch responseCode.statusCode {
                        case 200:
                            seal.fulfill(json)
                            break
                        default:
                            seal.reject(RequestError.unknownError)
                            break
                        }
                    }
                    catch let parseJSONError {
                        seal.reject(PMKError.invalidCallingConvention)
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }
        }
    }
}

