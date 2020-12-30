//
//  RPAuthRemoteAPI+Extension.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift

extension RPAuthRemoteAPI {
    /// 协议方式，成功返回JSON -----> RxSwift
    public func post<T: Request>(_ r: T) -> Observable<JSON> {
        guard let body = r.parameter else {
            return Observable.create { (observer) -> Disposable in
                observer.onError(RequestError.connectionError)
                return Disposables.create {  }
            }
        }
        
        let path = URL(string: r.host.appending(r.path))!
        
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
        
        return Observable.create { (observer) -> Disposable in
            AF.request(path, method: r.method, parameters: body, headers: headers).response { response in
                if let data = response.data ,let responseCode = response.response {
                    do {
                        let json = try JSON(data: data)
                        switch responseCode.statusCode {
                        case 200:
                            print("-------------\(json)")
                            observer.onNext(json)
                            observer.onCompleted()
                            break
                        case 201...299:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        case 400...499:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        case 500...599:
                            observer.onError(RequestError.serverError)
                            break
                        case 600...699:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        default:
                            observer.onError(RequestError.unknownError)
                            break
                        }
                    }
                    catch let parseJSONError {
                        observer.onError(parseJSONError)
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }
            return Disposables.create {  }
        }
    }
}

extension RPAuthRemoteAPI {
    /// 协议方式，成功返回JSON -----> RxSwift
    public func requestData<T: Request>(_ r: T) -> Observable<JSON> {
        guard let body = r.parameter else {
            return Observable.create { (observer) -> Disposable in
                observer.onError(RequestError.connectionError)
                return Disposables.create {  }
            }
        }
        
        let path = URL(string: r.host.appending(r.path))!
        
        let headers: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded",
                                    "version" : "318",
                                    "token" : "dd3063e8-b204-4046-96f5-5cef43b02ef2",
                                    "appId" : "e2766ff90db544ab9b3c7eaa8b834120",
                                    "type" : "1",
                                    "channel" : "iOS"]
        
        // body
        var parameters = Encryption.dictWithParamerters(maps: body)
        parameters.removeValue(forKey: "appSecret")
        parameters.removeValue(forKey: "appIdr")
        
        return Observable.create { (observer) -> Disposable in
            AF.request(path, method: r.method, parameters: parameters, headers: headers).response { response in
                if let data = response.data ,let responseCode = response.response {
                    do {
                        let json = try JSON(data: data)
                        switch responseCode.statusCode {
                        case 200:
                            print("-------------\(json)")
                            observer.onNext(json)
                            observer.onCompleted()
                            break
                        case 201...299:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        case 400...499:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        case 500...599:
                            observer.onError(RequestError.serverError)
                            break
                        case 600...699:
                            observer.onError(RequestError.authorizationError(json))
                            break
                        default:
                            observer.onError(RequestError.unknownError)
                            break
                        }
                    }
                    catch let parseJSONError {
                        observer.onError(parseJSONError)
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }
            return Disposables.create {  }
        }
    }
}
