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
        
//        HTTPRequest().authRemoteAPIWith(ChatListWithRequest(parameter: [:])) { [weak self] (result) in
//            guard let `self` = self else { return }
//            self.loading.onNext(false)
//            switch result {
//            case .success(let returnJson) :
//                if returnJson["returnCode"].intValue == 601 {
//                    self.error.onNext(returnJson["returnMsg"].stringValue)
//                } else if returnJson["returnCode"].intValue == 201 {
//                    self.error.onNext(returnJson["returnMsg"].stringValue)
//                } else {
//                    self.messageListArray = returnJson["data"].arrayValue.map({ (json) -> MessageModel in
//                        return MessageModel(json: json)
//                    })
//                    if self.messageListArray.count != 0 {
//                        self.messageListSubject.onNext(self.messageListArray)
//                    } else {
//                        self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
//                    }
//                }
//                break
//            case .failure(let failure) :
//                switch failure {
//                case .connectionError:
//                    self.error.onNext(NSLocalizedString("Request Timed Out", comment: ""))
//                    break
//                case .authorizationError(let errorJson):
//                    self.error.onNext(errorJson["returnMsg"].stringValue)
//                    break
//                case .statusCodeError(let errorJson):
//                    self.error.onNext(errorJson["returnMsg"].stringValue)
//                    break
//                case .unknownError:
//                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
//                    break
//                case .isAlert(let errorJson):
//                    self.error.onNext(errorJson["returnMsg"].stringValue)
//                    break
//                default :
//                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
//                    break
//                }
//            }
//        }
    }
}

extension MessageListViewModel {
    /// 获取用户信息 登录socket
    public func fetchChatInformation() {
        HTTPRequest().authRemoteAPIWith(ChatInfoListWithRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let returnJson) :
                print("================\(returnJson)")
                // 连接Socket服务器
                let socket = SocketManager.sharedInstance()
                let infoModel = ChatInfoModel(json: returnJson["data"])
                    socket.fetchSocketInfoWith(model: infoModel)
                    socket.isDesk = true
                    socket.connectSocket()
                break
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext("请求超时")
                    break
                case .authorizationError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                default :
                    self.error.onNext("Unknown Error")
                    break
                }
            }
        }
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
