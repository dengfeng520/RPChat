//
//  MessageBodyModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct MessageBodyModel: Codable {
    public var createTime,messageId,msg,photo,schoolId,toUserId,toUserName,type,myUserId,groupId: String
    public var fromUserId,fromUserName: String
    public var isSendSuccess: Bool
    public var timeOut: Int
    public var isCache: Bool
    public var isUserTouch: Bool
}

extension MessageBodyModel {
    init?(data: Data) {
        guard let model = try? JSONDecoder().decode(MessageBodyModel.self, from: data) else { return nil }
        self = model
    }
    
    init?(json: JSON) {
        fromUserId = json["userId"].stringValue
        createTime = json["createTime"].stringValue
        fromUserName = json["userName"].stringValue
        messageId = json["messageId"].stringValue
        msg = json["msg"].stringValue
        photo = json["photo"].stringValue
        schoolId = json["schoolId"].stringValue
        toUserId = json["toUserId"].stringValue
        toUserName = json["toUserName"].stringValue
        type = json["type"].stringValue
        myUserId = json["myUserId"].stringValue
        groupId = json["groupId"].stringValue
        isSendSuccess = true
        timeOut = 0
        isCache = false
        isUserTouch = false
    }
}
