//
//  AuthRemoteAPI.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct AuthRemoteAPI: RequestSender {
    func authRemoteAPIWith<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void) {
        guard r.path != nil else {
            completion(ApiResult.failure(.serverError))
            return
        }
        guard r.host != nil else {
            completion(ApiResult.failure(.serverError))
            return
        }
        guard r.host?.isEmpty == false else {
            completion(ApiResult.failure(.serverError))
            return
        }
        let path = URL(string: r.host!.appending(r.path!))!
        var headers: HTTPHeaders!
        headers = ["Content-Type" : "application/x-www-form-urlencoded",
        "token" : "",
        "version" : "\(DeviceInfo.versionNum)",
        "appId":  "",
        "type" : "1",
        "channel" : "iOS"]
        // body
        guard var body = r.parameter else {
            return
        }
        if r.host!.contains("m.boxkj") || r.host!.contains("/move/") {
            body.updateValue("move" as AnyObject, forKey: "appId")
        } else {
            if let appidStr = AccountData.fetchOpenId() {
                body.updateValue(appidStr as AnyObject, forKey: "appId")
            }
        }
        body.removeValue(forKey: "appSecret")
        body.removeValue(forKey: "appId")
        
        AF.request(path, method: r.method, parameters: body, headers: headers).response { response in
            if let error = response.error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            } else if let data = response.data ,let responseCode = response.response {
                do {
                    let responseJson = try JSON(data: data)
                    switch responseCode.statusCode {
                    case 200:
                        completion(ApiResult.success(responseJson))
                    case 201:
                        completion(ApiResult.failure(.isAlert(responseJson)))
                    case 400...499:
                        completion(ApiResult.failure(.authorizationError(responseJson)))
                    case 500...599:
                        completion(ApiResult.failure(.serverError))
                    case 601:
                        completion(ApiResult.failure(.authorizationError(responseJson)))
                    case 602:
                        completion(ApiResult.failure(.authorizationError(responseJson)))
                    default:
                        completion(ApiResult.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(ApiResult.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
        }
    }
}

extension AuthRemoteAPI {
    func dictWithToParamertersWith(_ parameter: [String : String]) -> [String : String] {
        var maps = [String : String]()
        let date = Date(timeIntervalSinceNow: 0)
        let time = date.timeIntervalSince1970 * 1000
        
        maps.updateValue("\(time)", forKey: "timestamp")
        // appkey
        maps.updateValue(appkey, forKey: "appSecret")
        
        return maps
    }
}
