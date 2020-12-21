//
//  ConversatListViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

public class MessageListViewModel: PublicViewModel {
    public var messageListArray: [MessageModel] = [MessageModel]()
    public let messageListSubject : PublishSubject<[MessageModel]> = PublishSubject()
    
    public let messageListTapped = PublishSubject<IndexPath>()
    

    public override init() {
        super.init()
            
        messageListTapped.asObservable().subscribe(onNext: { [weak self] (index) in
            guard let `self` = self else { return }
            
        }).disposed(by: bag)
    }

    public func fetchMessageList() {
        self.loading.onNext(true)
        HTTPRequest().authRemoteAPIWith(ChatListWithRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                if returnJson["returnCode"].intValue == 601 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else if returnJson["returnCode"].intValue == 201 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else {
                    self.messageListArray = returnJson["data"].arrayValue.map({ (json) -> MessageModel in
                        return MessageModel(json: json)
                    })
                    if self.messageListArray.count != 0 {
                        self.messageListSubject.onNext(self.messageListArray)
                    } else {
                        self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
                    }
                }
                break
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(NSLocalizedString("Request Timed Out", comment: ""))
                    break
                case .authorizationError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .statusCodeError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .unknownError:
                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
                    break
                case .isAlert(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                default :
                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
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
