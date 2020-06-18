//
//  HTTPRequest.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON
import CommonCrypto

let appkeyChar: String  = "e8167ef026cbc5e456ab837d9d6d9254"

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

protocol Upload {
    var path: String {get}
    var method: HTTPMethod {get}
    var imgData: Data {get}
    var parameter: [String: AnyObject]? {get}
    var host: String {get}
}

extension Upload {
   var parameter: [String: AnyObject] {
        return [:]
    }
}

enum ApiResult {
    case success(JSON)
    case failure(RequestError)
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case authenticationFailed(JSON)
    case serverUnavailable
    case statusCodeError(JSON)
    case isAlert(JSON)
}

protocol RequestSender {
    func requestWithMap<T: Request>(_ r: T, completion: @escaping (ApiResult) -> Void)
}

protocol Decodable {
    static func jsonFromModel(json: Dictionary<String, Any>) -> Any?
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
        var headers: HTTPHeaders?
        // 版本号起初，围绕着代码的可维护性、可测试性、可重用性以及可协作性，根据项目预期的规模，我们会有很多种不同的选择
        let infoDic: Dictionary<String , Any>! = Bundle.main.infoDictionary!
        let infoChar: String! = infoDic["CFBundleShortVersionString"] as? String ?? ""
        let versionNum = infoChar.replacingOccurrences(of: ".", with: "")
        // 学校信息
        let openId = AccountData.fetchOpenId()
        if let token = AccountData.fetchUserToken() {
            headers = ["Content-Type" : "application/x-www-form-urlencoded",
                       "token" : "\(token)",
                       "version" : "\(versionNum)",
                       "appId": openId ?? "",
                       "type" : "1",
                       "channel" : "iOS"]
        } else {
            headers = ["Content-Type" : "application/x-www-form-urlencoded",
                       "version" : "\(versionNum)",
                       "appId": openId ?? "",
                       "type" : "1",
                       "channel" : "iOS"]
        }
      
        // body
        var postParameters = r.parameter
        if r.host!.contains("m.boxkj") || r.host!.contains("/move/") {
            postParameters?.updateValue("move" as AnyObject, forKey: "appId")
        } else {
            let appidStr = AccountData.fetchOpenId()
            if let appidStr = appidStr {
                postParameters?.updateValue(appidStr as AnyObject, forKey: "appId")
            }
        }
        var postMaps = dictWithParamerters(maps: postParameters ?? [:])
        postMaps.removeValue(forKey: "appSecret")
        postMaps.removeValue(forKey: "appId")
        
        AF.request(path, method: r.method, parameters: postMaps, headers: headers).response { response in
            if let error = response.error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            } else if let data = response.data ,let responseCode = response.response {
                do {
                    let responseJson = try JSON(data: data)
                    print("responseJSON================== : \(responseJson)")
                    switch responseCode.statusCode {
                    case 200:
                        if responseJson["code"] == "201" || responseJson["returnCode"] == "201" {
                            completion(ApiResult.failure(.isAlert(responseJson)))
                        }else if responseJson["code"] == "202" || responseJson["returnCode"] == "202" {
                            completion(ApiResult.success(responseJson))
                        }  else if responseJson["code"] == "602" || responseJson["returnCode"] == "602" {
                            completion(ApiResult.failure(.authorizationError(responseJson)))
                        } else {
                            completion(ApiResult.success(responseJson))
                        }
                    case 400...499:
                        completion(ApiResult.failure(.authorizationError(responseJson)))
                    case 500...599:
                        completion(ApiResult.failure(.serverError))
                    case 601:
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
    /// MD5加密
    func md5withString(strs: String) -> String! {
      let str = strs.cString(using: String.Encoding.utf8)
      let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
      let digestLen = Int(CC_MD5_DIGEST_LENGTH)
      let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
      CC_MD5(str!, strLen, result)
      let hash = NSMutableString()
      for i in 0 ..< digestLen {
          hash.appendFormat("%02x", result[i])
      }
      result.deinitialize(count: 0)
      return String(format: hash as String)
    }
    /// 获取当前时间戳
    func fetchSystemCurrentTime() -> String {
        //获取当前时间
        let now = NSDate()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval) * 1000
        return "\(timeStamp)"
    }
    /// 加密处理
    func dictWithParamerters(maps: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        let timer = fetchSystemCurrentTime()
        var muMaps = maps
        muMaps.updateValue(timer as AnyObject, forKey: "timestamp")
        muMaps.updateValue(appkeyChar as AnyObject, forKey: "appSecret")
//        let strToSign = MapsKeysSort.charSort(withMaps: muMaps)
//        let signValidate = MapsKeysSort.md5withString(strToSign)
//        muMaps.updateValue(signValidate as AnyObject, forKey: "sign")
        return muMaps
    }
}
