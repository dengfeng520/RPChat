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
import PromiseKit

extension RPAuthRemoteAPI {
    /// 调用接口，成功返回JSON -----> PromiseKit
    public func post(with body: [String : AnyObject], _ path: String) -> Promise<JSON> {
        let headers: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded"]
        return Promise<JSON> { seal in
            AF.request(path, method: .post, parameters: body, headers: headers).response { response in
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

extension RPAuthRemoteAPI {
    /// 协议方式，成功返回JSON -----> RxSwift
    public func post<T: Request>(_ r: T) -> Observable<JSON> {
        guard let path = URL(string: r.host.appending(r.path)) else {
            return .error(RequestError.unknownError)
        }
        
        var headers: [String : String]?
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
         
        var urlRequest = URLRequest(url: path, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = r.method.rawValue
        if let parameter = r.parameter {
            // --> Data
            let parameterData = parameter.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\(param.value as! String)"
            }.data(using: .utf8)
            urlRequest.httpBody = parameterData
        }
        // 此处也可以使用RxSwift 封装好的
        return Observable.create { (observer) -> Disposable in
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print(error)
                    observer.onError(RequestError.connectionError)
                } else if let data = data ,let responseCode = response as? HTTPURLResponse {
                    do {
                        let json = try JSON(data: data)
                        switch responseCode.statusCode {
                        case 200:
                            print("json-------------\(json)")
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
                            observer.onError(RequestError.timeoutError)
                            break
                        }
                    }
                    catch let parseJSONError {
                        observer.onError(RequestError.timeoutError)
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }.resume()
            return Disposables.create { }
        }
    }
}
