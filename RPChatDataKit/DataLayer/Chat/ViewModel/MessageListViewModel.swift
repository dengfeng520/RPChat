//
//  ConversatListViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation   
import RxSwift
import PromiseKit
import SwiftyJSON

public class MessageListViewModel: PublicViewModel {
    public var messageListArray: [MessageModel] = [MessageModel]()
    public let messageListSubject : PublishSubject<[MessageModel]> = PublishSubject()
    
    public let messageListTapped = PublishSubject<IndexPath>()
    private let errorMessagesSubject = PublishSubject<Error>()
    
    public override init() {
        super.init()
        
        messageListTapped.asObservable().subscribe(onNext: { [weak self] (index) in
            guard let `self` = self else { return }
            
        }).disposed(by: disposeBag)
        
        
    }
    
    // 获取列表失败处理
    func indicateMessageListError(_ error: Error) {
        errorMessagesSubject.onNext(error)
    }
    
    /// 获取消息列表 获取用户信息 登录socket Observable
    public func fetchMessageList() {
        self.loading.onNext(true)
//        let _ = RPAuthRemoteAPI().requestData(ChatListWithRequest(parameter: [:]))
//            .flatMap({ (returnJson) in
//                return RPAuthRemoteAPI().requestData(ChatInfoListWithRequest.init(parameter: [:]))
//            }).subscribe { (json) in
//                print("subscribe---------获取消息列表-----------: \(json)")
//            } onError: { (error) in
//
//            } onCompleted: {
//
//            } onDisposed: {
//
//            }

        // 串行组合
//        let _ = Observable.concat([RPAuthRemoteAPI().requestData(ChatListWithRequest(parameter: [:])),RPAuthRemoteAPI().requestData(ChatInfoListWithRequest(parameter: [:]))]).subscribe { (json) in
//
//        } onError: { (error) in
//            self.loading.onNext(false)
//        } onCompleted: {
//            self.loading.onNext(false)
//        } onDisposed: {
//
//        }
        // 并行组合
        Observable.zip(
            RPAuthRemoteAPI().requestData(ChatListWithRequest(parameter: [:])),
            RPAuthRemoteAPI().requestData(ChatInfoListWithRequest(parameter: [:]))
        ).subscribe(onNext: { [weak self] (returnJson, chatInfo) in
            guard let `self` = self else { return }
            print("---------获取消息列表-----------: \(returnJson)")
//            let messageArray = [["status":"1","userId":"58888","type":"1","groupId":"","lastMsg":"梦到的故事太长","userName":"半神之弓","createTime":"09:12","photo":"houyi"],["status":"1","userId":"58888","type":"1","groupId":"","lastMsg":"你对着月亮许了什么愿？","userName":"寒月公主","createTime":"09:45","photo":"change"],["status":"1","userId":"588888","type":"1","groupId":"","lastMsg":"千窟为佑，太平无忧","userName":"破魔之箭","createTime":"10:23","photo":"jialuo"],["status":"1","userId":"588888","type":"1","groupId":"","lastMsg":"在无数的碎片中找到你","userName":"千金重弩","createTime":"11:45","photo":"sunshangxiang"]]
//
//            self.messageListArray = messageArray.map({ (json) -> MessageModel in
//                return MessageModel(json: JSON(json))
//            })
            self.messageListArray = returnJson["data"].arrayValue.map({ (json) -> MessageModel in
                return MessageModel(json: json)
            })
            if self.messageListArray.count != 0 {
                self.messageListSubject.onNext(self.messageListArray)
            } else {
                self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
            }
            print("---------获取登录消息-----------: \(chatInfo)")
            // 连接Socket服务器
            let socket = SocketManager.sharedInstance()
            let infoModel = ChatInfoModel(json: returnJson["data"])
            socket.fetchSocketInfoWith(model: infoModel)
            socket.isDesk = true
            socket.connectSocket()
        }, onError: { [weak self] error in
            guard let `self` = self else { return }
            print("取得 json 失败 Error: \(error.localizedDescription)")
            self.loading.onNext(false)
            self.errorSubject.onNext(NSLocalizedString("Unknown Error", comment: ""))
        }, onCompleted: { [weak self] in
            guard let `self` = self else { return }
            print("取得 json 任务成功完成")
            self.loading.onNext(false)
        }).disposed(by: disposeBag)
    }
}

extension MessageListViewModel {
    public func converFriendsModel(_ model: MessageModel) -> FriendsModel {
        var friendsModel: FriendsModel = FriendsModel()
        friendsModel.type = model.type
        friendsModel.userName = model.userName
        if model.type == "2" {
            friendsModel.userId = model.groupId
        } else {
            friendsModel.userId = model.userId
        }
        return friendsModel
    }
}
