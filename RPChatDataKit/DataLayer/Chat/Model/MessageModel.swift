//
//  ConversatModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/17.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 消息类型
public enum MessageType {
    // 未知消息
    case unknown
    // 系统
    case system
    // 文字
    case text
    // 图片
    case image
    // 语音
    case voice
    // 视频
    case video
    // 文件
    case file
    // 位置
    case location
    // 抖一抖
    case shake
}

public enum MessageReadState {
    // 未读
    case unRead
    // 已读
    case readed
}

public struct MessageModel {
    public var status,userId,type,groupId,lastMsg,userName,createTime,photo: String
    public var isCache: Bool
    public var messageType: MessageType
    public var readState: MessageReadState
}

extension MessageModel {
    init(json: JSON) {
        status = json["status"].stringValue
        userId = json["userId"].stringValue
        type = json["type"].stringValue
        groupId = json["groupId"].stringValue
        lastMsg = json["lastMsg"].stringValue
        userName = json["userName"].stringValue
        createTime = json["createTime"].stringValue
        photo = json["photo"].stringValue
        messageType = .text
        readState = .readed
        isCache = false
    }
}
