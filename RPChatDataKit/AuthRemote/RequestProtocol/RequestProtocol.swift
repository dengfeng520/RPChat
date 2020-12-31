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

public protocol RequestProtocol {
    
}
/// 请求服务器相关
public protocol Request {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameter: [String: AnyObject]? {get}
    var host: String {get}
}

extension Request {
    var parameter: [String: AnyObject] {
        return [:]
    }
}
/// 请求服务器失败时 错误码
public enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case notFound
    case serverError
}
