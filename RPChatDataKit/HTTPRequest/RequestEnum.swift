//
//  RequestEnum.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

enum ApiResult {
    case success(JSON)
    case failure(RequestError)
}

public enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case notFound
    case serverError
}
