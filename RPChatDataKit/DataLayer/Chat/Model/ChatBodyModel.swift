//
//  ChatBodyModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct ChatBodyModel {
    public var createTime,messageId,msg,photo,schoolId,toUserId,toUserName,type,myUserId,groupId: String
    public var fromUserId,fromUserName: String
    public var isSendSuccess: Bool
    public var timeOut: Int
    public var isCache: Bool
    public var isUserTouch: Bool
}

extension ChatBodyModel {
    public init(json: JSON) {
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
    
    public init(jsonData: JSON) {
        fromUserId = jsonData["fromUserId"].stringValue
        createTime = jsonData["createTime"].stringValue
        fromUserName = jsonData["fromUserName"].stringValue
        messageId = jsonData["messageId"].stringValue
        msg = jsonData["msg"].stringValue
        photo = jsonData["photo"].stringValue
        schoolId = jsonData["schoolId"].stringValue
        toUserId = jsonData["toUserId"].stringValue
        toUserName = jsonData["toUserName"].stringValue
        type = jsonData["type"].stringValue
        myUserId = jsonData["myUserId"].stringValue
        groupId = jsonData["groupId"].stringValue
        isSendSuccess = false
        timeOut = 0
        isCache = true
        isUserTouch = true
    }
}
