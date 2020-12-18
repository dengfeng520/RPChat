//
//  APIConfig.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation

public let appkey = "e8167ef026cbc5e456ab837d9d6d9254"
#if DEBUG
/// 测试服务器
public let __serverTestURL = "http://a.sxstczx.com/"
#else
/// release服务器
public let __serverTestURL = "http://a.sxstczx.com/"
#endif

///1 登录
public let __apiFetchSignIn = "auth/oauth/token"
///2 获取会话列表
public let __apiFetchChatList = "/app/chat/listChats"
///3 获取好友列表
public let __apiFetchFriendsList = "/app/chat/listFriends"
///4 获取消息列表
public let __apiFetchMessagesList = "/app/chat/getChat"
///5 修改会话状态为已读
public let __apiFetchUpdateReadStatusList = "/app/chat/updateReadStatus"
///6 获取消息需要的信息
public let __apiFetchChatInfo = "/app/chat/getChatInfo"
///7 修改会话状态为已读
public let __apiFetchUpdateReadStatus = "/app/chat/updateReadStatus"
