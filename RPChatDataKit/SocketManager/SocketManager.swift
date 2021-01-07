//
//  SocketManager.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift
import CocoaAsyncSocket

public class SocketManager: NSObject {
    // 服务器Host
    var serverHost: String = "192.168.1.106"
    // 服务器Port
    var serverPort = 6666
    // 心跳计时器
    private var heartbeatTimer: DispatchSourceTimer?
    var isHeartbeatTimeSuspend = false
    // 心跳超时计时器
    var timeOutTimer: DispatchSourceTimer?
    var isTimeOutResume = false
    // 心跳超时计数
    var timeOutNum = 0
    // 最后一次收到服务器心跳回复时间戳
    var lastReadTime: String = String()
    // 前台 or 后台
    public var isDesk = false
    // 聊天信息
    public var infoModel: ChatInfoModel = ChatInfoModel(json: JSON([:]))
    // 发送消息成功回调
    public var sendMessageSucessClosures: ((_ messageId: MessageIdModel) -> Void)?
    public let sendMessageSucessSubject : PublishSubject<MessageIdModel> = PublishSubject()
    // 服务器主动发消息闭包
    public var receiveServrerMessageClosures: ((_ messageModel: MessageBodyModel) -> Void)?
    public let receiveServrerMessageSubject : PublishSubject<MessageBodyModel> = PublishSubject()
    // 账号被踢
    public var siginOutServerMessageClosures: (() -> Void)?

    private static var _sharedInstance: SocketManager?
    // 是否已经连接Socket服务器
    public var isConnect = false
    // 是否已经登录成功
    public var isSigin = false
    
    override init() {
        super.init()
    }
    
    public static let sharedInstance = SocketManager()
    
    
    // 构建Socket客户端
    lazy var socketManager: GCDAsyncSocket = {
        let socketManager = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        return socketManager
    }()
    
    // 连接socket服务器
    func connectSocket() {
        if isConnect == false {
            do {
                try socketManager.connect(toHost: serverHost, onPort: UInt16(serverPort), withTimeout: 5)
            } catch {
                print("Socket conncet error")
            }
        }
    }
    
    // TODO: - 账号被踢时 销毁Socket实例
    class func clearnSocket() {
        if _sharedInstance != nil {
            _sharedInstance = nil
        }
    }
    
    // 心跳计时器
    private func configHeartbeatTimer() {
        isSigin = true
        if heartbeatTimer == nil {
            heartbeatTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            heartbeatTimer?.schedule(deadline: .now(), repeating: .seconds(5))
            heartbeatTimer?.setEventHandler(handler: { [weak self] in
                guard let `self` = self else { return }
                // 返回主线程更新UI
                DispatchQueue.main.async {
                    self.socketDidConnectBeginSendBeat()
                }
            })
        }
        isHeartbeatTimeSuspend = false
        // 启动时间
        heartbeatTimer!.resume()
    }
    
    // 心跳超时计时器
    private func configTimeOut() {
        if timeOutTimer == nil {
            timeOutTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timeOutTimer?.schedule(deadline: .now(), repeating: .seconds(5))
            timeOutTimer?.setEventHandler(handler: { [weak self] in
                guard let `self` = self else { return }
                DispatchQueue.main.async {
                    self.timeOutNum = self.timeOutNum + 1
                    // 断开后每5秒 重连一次
                    if self.timeOutNum >= 5 {
                        self.connectSocket()
                    }
                }
            })
        }
        timeoutResume()
    }
    
    func timeoutResume() {
        if timeOutTimer != nil {
            // 启动时间
            isTimeOutResume = true
            timeOutTimer?.resume()
        }
    }
    
    // 获取Socket登录信息
    func fetchSocketInfoWith(model: ChatInfoModel) {
        infoModel = model
        serverHost = model.serverIp
        serverPort = model.port
    }
}


extension SocketManager: GCDAsyncSocketDelegate {
    public func socket(socket : GCDAsyncSocket, didConnectToHost host:String, port p:UInt16) {
        
    }
    /// 连接服务器成功
    public func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("=============Socket conncet success")
        if timeOutTimer != nil {
            // 暂停
            timeOutNum = 0
            timeOutTimer?.suspend()
            print("timeOutTimer=====\(String(describing: timeOutTimer))")
        }
        isTimeOutResume = false
        isConnect = true
        // 登录
        socketDidConnectCreatSigin()
        socketManager.readData(withTimeout: -1, tag: 0)
    }
    /// 收到服务器的消息
    public func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let code = fetchServerCodeWithData(data: data)
        if code == cmdCodeMode.siginSuccessMode.rawValue {
            print("=======================Socket 登录成功")
            //            let model: SocketModel = unSinginPackWithData(data: data)
            // 登录成功 开启心跳计时器
            configHeartbeatTimer()
        } else if code == cmdCodeMode.jumpingSuccessMode.rawValue {
            //            let model: SocketModel = jumpingPackWithData(data: data)
            print("=======================心跳正常")
        } else if code == cmdCodeMode.receivedMessageMode.rawValue {
            let model: MessageIdModel = sendFeedbackPackWithData(data: data)
            if let sendMessageSucessClosures = sendMessageSucessClosures {
                sendMessageSucessClosures(model)
            }
        } else if code == cmdCodeMode.serverPushMessageMode.rawValue {
            let model = serverPushMessageWithData(data: data)
            if let receiveServrerMessageClosures = receiveServrerMessageClosures {
                receiveServrerMessageClosures(model)
            }
            self.receiveServrerMessageSubject.onNext(model)
        } else if code == cmdCodeMode.siginOutMode.rawValue {
            //            let model = jumpingPackWithData(data: data)
            if let siginOutServerMessageClosures = siginOutServerMessageClosures {
                siginOutServerMessageClosures()
            }
        } else {
            //            let model = serverPushMessageWithData(data: data)
        }
        socketManager.readData(withTimeout: -1, tag: 0)
    }
    
    func isHeartbeatTimeSuspendWith() {
        if heartbeatTimer != nil && isHeartbeatTimeSuspend == false {
            isHeartbeatTimeSuspend = true
            heartbeatTimer?.suspend()
        }
    }
    
    /// 当socket断开后执行
    public func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        isConnect = false
        isSigin = false
        isHeartbeatTimeSuspendWith()
        if isTimeOutResume == false {
            if (timeOutTimer == nil) {
                configTimeOut()
            } else {
                timeoutResume()
            }
        }
    }
}
