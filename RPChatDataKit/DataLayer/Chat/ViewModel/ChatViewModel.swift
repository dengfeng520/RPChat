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
    public var friendsModel: FriendsModel = FriendsModel()
    
    /// 获取消息列表
    public func fetchChatList(_ parameter: [String : String]) {
        self.loading.onNext(true)
        RPAuthRemoteAPI().requestData(MessageListWithRequest(parameter: parameter as [String : AnyObject]))
            .subscribe(onNext: { returnJson in
                self.chatListArray = returnJson["data"]["messages"]["data"].arrayValue.map({ (json) -> ChatBodyModel in
                    return ChatBodyModel(json: json)
                })
                if self.chatListArray.count != 0 {
                    self.chatListSubject.onNext(self.chatListArray)
                } else {
                    self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
                }
            }, onError: { errorJson in
                self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
                self.loading.onNext(false)
            }, onCompleted: {
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
}
