//
//  RequestProtocol.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

/// 请求服务器相关
public protocol Request {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameter: [String: AnyObject]? {get}
    var host: String {get}
    associatedtype Response: Codable
}

extension Request {
    var parameter: [String: AnyObject] {
        return [:]
    }
}
/// 错误码
public enum RequestError: Error {
    case unknownError
    case connectionError
    case timeoutError
    case authorizationError(JSON)
    case notFound
    case serverError
}
