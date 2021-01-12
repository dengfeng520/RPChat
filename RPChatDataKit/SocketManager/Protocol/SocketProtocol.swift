//
//  SocketProtocol.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation

// TODO: - 协议
protocol SocketProtocol {
    // 发送登录包
    func socketDidConnectCreatSigin() -> Void
    // 发送心跳包
    func socketDidConnectBeginSendBeat() -> Void
    // 发送前数据必须转成Data类型
    func beforeSendingDataConversion(sendingBody: [String : String]) -> Data
    // 发送消息包
    func sendMessageWithPack(messageBody: [String : String]) -> Void
    // 发送消息成功回调
    var sendMessageSucessClosures: ((_ messageId: MessageIdModel) -> Void)? { get set }
    // 服务器主动发消息闭包
    var receiveServrerMessageClosures: ((_ messageModel: MessageBodyModel) -> Void)? { get set }
    // 账号被踢
    var siginOutServerMessageClosures: (() -> Void)? { get set }
}

// 可选
extension SocketProtocol {
    // 发送登录包
    func socketDidConnectCreatSigin() -> Void { }
    // 发送心跳包
    func socketDidConnectBeginSendBeat() -> Void { }
    // 发送前数据必须转成Data类型
    func beforeSendingDataConversion(sendingBody: [String : String]) -> Data {
        return Data()
    }
    // 发送消息包
    func sendMessageWithPack(messageBody: [String : String]) -> Void { }
}

// TODO: - ============= 命令字
public enum cmdCodeMode: UInt8 {
    // 登录命令字
    case siginMode = 0x01
    // 心跳
    case heartbeatMode = 0x02
    // 发送消息
    case sendMessageMode = 0x03
    // 登录成功 服务器返回
    case siginSuccessMode = 0x31
    // 收到心跳 服务器返回
    case jumpingSuccessMode = 0x32
    // 发送消息 服务器返回
    case receivedMessageMode = 0x33
    // 服务器主动推消息（单聊消息和群聊消息）
    case serverPushMessageMode = 0x34
    // 账号被踢
    case siginOutMode = 0x35
    // 校验位
    case checkDigitMode = 0x88
}
