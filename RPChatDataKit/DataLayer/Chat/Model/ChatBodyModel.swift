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
    /// 消息id
    public var messageId: String
    /// 消息内容
    public var msg: String
    /// 图片消息
    public var photo: String
    /// 接收人id
    public var toUserId: String
    /// 接收人昵称
    public var toUserName: String
    /// 群id
    public var groupId: String
    /// 消息类型 （文字，emoji，图片，视频，位置，语音）
//    @Default<MessageType>
    public var type: MessageType
    /// 发送人id
    public var fromUserId: String
    /// 发送人昵称
    public var fromUserName: String
    /// 发送时间
    public var createTime: String
    /// 缓存model宽，后期优化
    public var modelWidth: Int
    /// 缓存model高，后期优化
    public var modelHeight: Int
        
    private enum CodingKeys: String,CodingKey {
        case messageId
        case msg
        case photo
        case toUserId
        case toUserName
        case groupId
        case type
        case fromUserId
        case fromUserName
        case createTime
        case modelWidth
        case modelHeight
    }
}

extension ChatBodyModel: Decodable {
    public init?(_ data: Data) {
        guard let model = try? JSONDecoder().decode(ChatBodyModel.self, from: data) else { return nil }
        self = model
    }
}


