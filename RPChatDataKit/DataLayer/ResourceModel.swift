//
//  ResourceModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/1/28.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

/*
 请求失败时 服务器返回的数据结构 例如
 {
   "returnCode" : "601",
   "returnMsg" : "登录失效",
 }
 */

import Foundation

public struct ResourceModel {
    public let returnCode,returnMsg: String
    
    private enum CodingKeys: String,CodingKey {
        case returnCode
        case returnMsg
    }
}

extension ResourceModel: Codable {
    public init?(data: Data) {
        guard let model = try? JSONDecoder().decode(ResourceModel.self, from: data) else { return nil }
        self = model
    }
}
