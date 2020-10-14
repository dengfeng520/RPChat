//
//  SocketManagerPack.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import SwiftyJSON

extension SocketManager {
    // 服务器返回的命令字
    func fetchServerCodeWithData(data: Data) -> UInt16 {
        let packData: NSData = data as NSData
        // 命令字
        var cmdCode: UInt16 = 0
        packData.getBytes(&cmdCode, range: NSMakeRange(3, 1))
        return cmdCode
    }
    
    // 登录拆包操作
    func unSinginPackWithData(data: Data) -> SocketSigInModel {
        let packData: NSData = data as NSData
        // header
        var header: UInt16 = 0
        packData.getBytes(&header, range: NSMakeRange(0, 1))
        // 包长
        let packLength = data.count
        // 命令字
        var cmdCode: UInt16 = 0
        packData.getBytes(&cmdCode, range: NSMakeRange(3, 1))
        // 数据包
        let package = packData.subdata(with: NSMakeRange(4, packLength - 6))
        let returnChar: String = String(data: package, encoding: String.Encoding.utf8)!
        // 校验位
        var model = SocketSigInModel()
        model.cmdCode = cmdCode
        model.msg = returnChar
        
        return model
    }
    // 心跳拆包操作
    func jumpingPackWithData(data: Data) -> SocketSigInModel {
        let packData: NSData = data as NSData
        // header
        var header: UInt16 = 0
        packData.getBytes(&header, range: NSMakeRange(0, 1))
        // 包长
        let packLength = data.count
        // 命令字
        var cmdCode: UInt16 = 0
        packData.getBytes(&cmdCode, range: NSMakeRange(3, 1))
        // 数据包
        let package = packData.subdata(with: NSMakeRange(4, packLength - 6))
        let returnChar: String = String(data: package, encoding: String.Encoding.utf8)!
        var model = SocketSigInModel()
        model.cmdCode = cmdCode
        model.msg = returnChar
        
        return model
    }
    
    // 发送消息后 服务器反馈 拆包
    func sendFeedbackPackWithData(data: Data) -> MessageIdModel {
        let packData: NSData = data as NSData
        // header
        var header: UInt16 = 0
        packData.getBytes(&header, range: NSMakeRange(0, 1))
        // 包长
        let packLength = data.count
        // 命令字
        var cmdCode: UInt16 = 0
        packData.getBytes(&cmdCode, range: NSMakeRange(3, 1))
        // 数据包
        let package = packData.subdata(with: NSMakeRange(4, packLength - 6))
        let model = MessageIdModel(json: JSON(package))
        
        return model!
    }
    // 接收消息拆包操作
    func serverPushMessageWithData(data: Data) -> MessageBodyModel {
        let packData: NSData = data as NSData
        // 包长
        let packLength = data.count
        // 数据包
        let package = packData.subdata(with: NSMakeRange(4, packLength - 6))
        let json = JSON(package)
        print("收到消息==============\(json)")
        let model = MessageBodyModel(json: JSON(package))
        
        return model!
    }
}
