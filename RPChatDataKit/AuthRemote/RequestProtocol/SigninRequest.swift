//
//  SigninRequest.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import Alamofire

/// 登录
struct SigninRequest: Request {
    typealias Response = SigninRequest
    var parameter: [String : AnyObject]?
    var path: String
    var method: HTTPMethod = .post
    var host: String {
        return __serverTestURL
    }
}

extension SigninRequest: Decodable {
    static func dataFromModel(data: Data) -> Any? {
        return SignInModel(data: data)
    }
}

struct SigninResource: Request {
    typealias Response = SigninResource
    var parameter: [String : AnyObject]?
    var path: String
    var method: HTTPMethod = .post
    var host: String {
        return __serverTestURL
    }
}

extension SigninResource: Decodable {
    static func dataFromModel(data: Data) -> Any? {
        return SignInModel(data: data)
    }
}


