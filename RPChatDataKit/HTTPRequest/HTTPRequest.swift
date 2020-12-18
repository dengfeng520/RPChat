//
//  HTTPRequest.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CommonCrypto

protocol Request {
    var path: String? {get}
    var method: HTTPMethod {get}
    var parameter: [String: AnyObject]? {get}
    var host: String? {get}
}

extension Request {
    var parameter: [String: AnyObject] {
        return [:]
    }
}

protocol RequestSender {
    func requestWithMap<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void)
}

extension RequestSender {
    // 可选方法
    func requestWithMap<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void) {
        
    }
    func authRemoteAPIWith<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void) {
        
    }
}

struct HTTPRequest: RequestSender {
    // MARK: - POST
    func requestWithMap<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void) {
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
        // 缓存token
        if let token = AccountData.fetchToken() {
            headers = ["Content-Type" : "application/x-www-form-urlencoded; application/json; charset=utf-8;",
                       "Cookie" : "host=a",
                       "Authorization" : "Bearer \(token)"]
        } else {
            let authorization = "Basic " + "app:app".base64Encoded!
            headers = ["Content-Type" : "application/x-www-form-urlencoded; application/json; charset=utf-8;",
                       "Cookie" : "host=a",
                       "Authorization" : "\(authorization)"]
        }
        // body
        guard let body = r.parameter else {
            return
        }
        
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

extension HTTPRequest {
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
        let headers: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded",
                                   "version" : "318",
                                   "token" : "2a8d9c3f-c67a-4b89-aba0-f80014f5be12",
                                   "appId" : "e2766ff90db544ab9b3c7eaa8b834120",
                                   "type" : "1",
                                   "channel" : "iOS"]
        // body
        let body = r.parameter
        var parameters = dictWithParamerters(maps: body ?? [:])
        parameters.removeValue(forKey: "appSecret")
        parameters.removeValue(forKey: "appId")
        
        AF.request(path, method: r.method, parameters: parameters, headers: headers).response { response in
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

extension HTTPRequest {
    /// 获取当前时间戳
    func fetchSystemCurrentTime() -> String {
        //获取当前时间
        let now = NSDate()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval) * 1000
        return "\(timeStamp)"
    }
    func charSortWithMaps(_ maps: Dictionary<String, AnyObject>) -> String {
        let keys = maps.keys
        let results: [String] = keys.sorted()
        var sortStr: String = String()
        results.forEach { (categoryId) in
            if var value = maps[categoryId] {
                if value is Dictionary<String, AnyObject> {
                    value = charSortWithMaps(value as! Dictionary<String, AnyObject>) as AnyObject
                }
                if value is Dictionary<String, String> {
                    value = charSortWithMaps(value as! Dictionary<String, AnyObject>) as AnyObject
                }
                if sortStr.count != 0 {
                    sortStr = sortStr + "&"
                }
                sortStr = sortStr.appendingFormat("\(categoryId)=\(value)")
            }
        }
        return sortStr
    }
    
    func dictWithParamerters(maps: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        let timer = fetchSystemCurrentTime()
        var muMaps = maps
        muMaps.updateValue(timer as AnyObject, forKey: "timestamp")
        muMaps.updateValue(appkey as AnyObject, forKey: "appSecret")
        let signValidate = charSortWithMaps(muMaps).md5
        muMaps.updateValue(signValidate as AnyObject, forKey: "sign")
        return muMaps
    }
}

