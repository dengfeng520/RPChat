//
//  SocketManagerSeal.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

extension SocketManager {
    /// 登录封包操作
    func singinWithCmd(cmd: UInt8, bodyData: Data) -> Data {
           var header = 0xFE
           var cmdCode: UInt8 = cmd
           let data: NSMutableData = NSMutableData()
           var dataLenght: Int = 0
           if bodyData.count == 0 {
               dataLenght = 6
           } else {
               dataLenght = bodyData.count + 6
           }
           var checkDigit = cmdCodeMode.checkDigitMode.rawValue
           // 转换一个16位的整型数字
           var changeInt = CFSwapInt16(UInt16(dataLenght))
           
           data.append(&header, length: 1)
           data.append(&changeInt, length: 2)
           data.append(&cmdCode, length: 1)
           data.append(bodyData)
           data.append(&checkDigit, length: 2)
           
           return data as Data
       }
       
       /// 心跳封包
       func heartbeatWithCmd(cmd: UInt8, bodyData: Data) -> Data {
           var header = 0xFE
           var cmdCode: UInt8 = cmd
           let data: NSMutableData = NSMutableData()
           var dataLenght: Int = 0
           if bodyData.count == 0 {
               dataLenght = 6
           } else {
               dataLenght = bodyData.count + 6
           }
           var checkDigit = cmdCodeMode.checkDigitMode.rawValue
           
           // 转换一个16位的整型数字
           var changeInt = CFSwapInt16(UInt16(dataLenght))
           
           data.append(&header, length: 1)
           data.append(&changeInt, length: 2)
           data.append(&cmdCode, length: 1)
           data.append(bodyData)
           data.append(&checkDigit, length: 2)
           
           return data as Data
       }
    
    // 发消息封包
    func sendMessageWithCmd(cmd: UInt8, bodyData: Data) -> Data {
        var header = 0xFE
        var cmdCode: UInt8 = cmd
        let data: NSMutableData = NSMutableData()
        var dataLenght: Int = 0
        if bodyData.count == 0 {
            dataLenght = 6
        } else {
            dataLenght = bodyData.count + 6
        }
        var checkDigit = cmdCodeMode.checkDigitMode.rawValue
        
        // 转换一个16位的整型数字
        var changeInt = CFSwapInt16(UInt16(dataLenght))
        
        data.append(&header, length: 1)
        data.append(&changeInt, length: 2)
        data.append(&cmdCode, length: 1)
        data.append(bodyData)
        data.append(&checkDigit, length: 2)
        
        return data as Data
    }
}
