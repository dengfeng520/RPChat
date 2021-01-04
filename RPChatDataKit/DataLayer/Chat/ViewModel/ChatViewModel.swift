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
        RPAuthRemoteAPI().requestData(MessageListWithRequest(parameter: [:]))
            .subscribe(onNext: { returnJson in
                print("取得 json 成功: \(returnJson)")
                self.chatListArray = returnJson["data"].arrayValue.map({ (json) -> ChatBodyModel in
                    return ChatBodyModel(json: json)
                })
                if self.chatListArray.count != 0 {
                    self.chatListSubject.onNext(self.chatListArray)
                } else {
                    self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
                }
            }, onError: { errorJson in
                print("取得 json 失败 Error: \(errorJson.localizedDescription)")
                self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
                self.loading.onNext(false)
            }, onCompleted: {
                print("取得 json 任务成功完成")
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
}
