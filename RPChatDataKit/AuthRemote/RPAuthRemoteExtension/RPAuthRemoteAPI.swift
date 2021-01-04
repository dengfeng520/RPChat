//
//  RPAuthRemoteAPI.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift

public struct RPAuthRemoteAPI: AuthRemoteProtocol {
    /// 协议方式，成功返回JSON -----> RxSwift
    public func post<T: Request>(_ r: T) -> Observable<JSON> {
        let path = URL(string: r.host.appending(r.path))!
        
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
                            observer.onError(RequestError.unknownError)
                            break
                        }
                    }
                    catch let parseJSONError {
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }.resume()
            return Disposables.create { }
        }
    }
}

