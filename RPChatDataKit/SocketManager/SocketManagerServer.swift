//
//  SocketManagerServer.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation

extension SocketManager {
    /// 向服务器发送登录数据
    func socketWriteDataToServer(heartbeatBody: Dictionary<String, String>) {
        // 登录
        let body = beforeSendingDataConversion(sendingBody: heartbeatBody)
        let bodyData = singinWithCmd(cmd: cmdCodeMode.siginMode.rawValue, bodyData: body)
        socketManager.write(bodyData, withTimeout: -1, tag: 0)
    }
}

extension SocketManager: SocketProtocol {
    /// 发送前转换
    func beforeSendingDataConversion(sendingBody: [String : String]) -> Data {
        guard let data: Data = try? Data(JSONSerialization.data(withJSONObject: sendingBody,options: JSONSerialization.WritingOptions(rawValue: 1)))
            else { return Data() }
        return data
    }
    
    /// 发送登录包
    func socketDidConnectCreatSigin() {
        let userId: String = String()
        let siginBody = ["schoolId":"\(infoModel.school!)","userId":userId]
        socketWriteDataToServer(heartbeatBody: siginBody)
    }
    
    /// 发送心跳包
    func socketDidConnectBeginSendBeat() {
        let userId: String = String()
        var heartbeatBody = [String : String]()
        if (self.isDesk == true) {
            heartbeatBody = ["schoolId":infoModel.school!,"hb":"chat","userId":userId]
        } else {
            heartbeatBody = ["schoolId":infoModel.school!,"hb":"back","userId":userId]
        }
        let body = beforeSendingDataConversion(sendingBody: heartbeatBody)
        let bodyData = heartbeatWithCmd(cmd: cmdCodeMode.heartbeatMode.rawValue, bodyData: body)
        socketManager.write(bodyData, withTimeout: -1, tag: 0)
    }
    
    /// 发送消息
    func sendMessageWithPack(messageBody: [String : String]) -> Void {
        let body = beforeSendingDataConversion(sendingBody: messageBody)
        let bodyData = sendMessageWithCmd(cmd: cmdCodeMode.sendMessageMode.rawValue, bodyData: body)
        socketManager.write(bodyData, withTimeout: -1, tag: 0)
    }
}
