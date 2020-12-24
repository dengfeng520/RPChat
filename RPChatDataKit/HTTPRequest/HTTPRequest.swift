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
                                   "token" : "9e678ee6-69de-47b1-a069-6ed343626f49",
                                   "appId" : "e2766ff90db544ab9b3c7eaa8b834120",
                                   "type" : "1",
                                   "channel" : "iOS"]
        // body
        let body = r.parameter
        var parameters = Encryption.dictWithParamerters(maps: body ?? [:])
        parameters.removeValue(forKey: "appSecret")
        parameters.removeValue(forKey: "appId")
        print("parameters============\(parameters)")
        
        AF.request(path, method: r.method, parameters: parameters, headers: headers).response { response in
            if let error = response.error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            } else if let data = response.data ,let responseCode = response.response {
                do {
                    let responseJson = try JSON(data: data)
                    switch responseCode.statusCode {
                    case 200:
                        print("---------------\(responseJson)")
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


