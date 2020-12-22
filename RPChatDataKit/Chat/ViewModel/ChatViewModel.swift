//
//  ChatViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

public class ChatViewModel: PublicViewModel {
        
    public var chatListArray: [ChatBodyModel] = [ChatBodyModel]()
    public let chatListSubject : PublishSubject<[ChatBodyModel]> = PublishSubject()
    
    /// 获取消息列表
    public func fetchChatList(_ parameter: [String : String]) {
        self.loading.onNext(true)
        HTTPRequest().authRemoteAPIWith(MessageListWithRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                if returnJson["returnCode"].intValue == 601 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else if returnJson["returnCode"].intValue == 201 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else {
                    self.chatListArray = returnJson["data"].arrayValue.map({ (json) -> ChatBodyModel in
                        return ChatBodyModel(json: json)
                    })
                    if self.chatListArray.count != 0 {
                        self.chatListSubject.onNext(self.chatListArray)
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
