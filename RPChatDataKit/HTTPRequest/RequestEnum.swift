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
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case authenticationFailed(JSON)
    case serverUnavailable
    case statusCodeError(JSON)
    case isAlert(JSON)
}
