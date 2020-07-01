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
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchSignIn
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __serverTestURL
    }
}
