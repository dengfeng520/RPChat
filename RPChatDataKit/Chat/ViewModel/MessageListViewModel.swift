//
//  ConversatListViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
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
    
    public func fetchMessageList() {
        self.loading.onNext(true)
        let path = __chatServerURL + __apiFetchChatList
        self.loading.onNext(false)
        RPAuthRemoteAPI().post(with: [:], path)
            .subscribe(onNext: { returnJson in
                print("取得 json 成功: \(returnJson)")
                self.messageListArray = returnJson["data"].arrayValue.map({ (json) -> MessageModel in
                    return MessageModel(json: json)
                })
                if self.messageListArray.count != 0 {
                    self.messageListSubject.onNext(self.messageListArray)
                } else {
                    self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
                }
            }, onError: { error in
                print("取得 json 失败 Error: \(error.localizedDescription)")
                
            }, onCompleted: {
                print("取得 json 任务成功完成")
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
}

extension MessageListViewModel {
    /// 获取用户信息 登录socket
    public func fetchChatInformation() {
        
        loading.onNext(true)
        RPAuthRemoteAPI().requestData(ChatInfoListWithRequest(parameter: [:]))
            .subscribe(onNext: { returnJson in
                print("取得 json 成功: \(returnJson)")
                print("================\(returnJson)")
                // 连接Socket服务器
                let socket = SocketManager.sharedInstance()
                let infoModel = ChatInfoModel(json: returnJson["data"])
                socket.fetchSocketInfoWith(model: infoModel)
                socket.isDesk = true
                socket.connectSocket()
            }, onError: { errorJson in
                print("取得 json 失败 Error: \(errorJson.localizedDescription)")
                self.error.onNext("Unknown Error")
                self.loading.onNext(false)
            }, onCompleted: {
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
