//
//  ChatViewControllerSocket.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RPChatDataKit

extension ChatViewController {
    func bindSocketAbout() {
        // 收到消息
        socket.receiveServrerMessageSubject.subscribe(onNext: { messageBody in
            
        }).disposed(by: disposeBag)
    }
    
    /// 发消息
    func tapSendMessage(_ input: String) {
        var sendMessage = [String : String]()
        if viewModel.friendsModel.type == "1" {
            sendMessage = ["createTime":"\(CurrentTime.fetchSystemCurrentTime)",
                "fromUserId":"",
                "fromUserName":"",
                "messageId":"",
                "msg":"",
                "photo":"",
                "schoolId":"",
                "toUserId":"",
                "toUserName":"",
                "type":"1"]
        } else {
            sendMessage = ["createTime":"\(CurrentTime.fetchSystemCurrentTime)",
                "fromUserId":"",
                "fromUserName":"",
                "groupId":"",
                "messageId":"",
                "msg":"",
                "photo":"",
                "schoolId":"",
                "toUserId":"",
                "toUserName":"",
                "type":"2"]
        }
        socket.sendMessageWithPack(messageBody: sendMessage)
    }
}
