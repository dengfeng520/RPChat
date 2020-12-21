//
//  ChatRequest.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Alamofire

/// 获取会话列表
struct ChatListWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchChatList
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

/// 获取好友列表
struct FriendsListWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchFriendsList
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

/// 获取消息列表
struct MessageListWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchMessagesList
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

/// 修改会话状态为已读
struct UpdateReadStatusListWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchUpdateReadStatusList
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

/// 获取消息需要的信息
struct ChatInfoListWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchChatInfo
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

/// 修改会话状态为已读
struct ChatUpdateReadStatusWithRequest: Request {
    var parameter: [String : AnyObject]?
    var path: String? {
        return __apiFetchUpdateReadStatus
    }
    var method: HTTPMethod = .post
    var host: String? {
        return __chatServerURL
    }
}

