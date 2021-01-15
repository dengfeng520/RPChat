//
//  ChatViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

public class ChatViewModel: PublicViewModel {
    /// 消息列表
    public var chatListArray: [ChatBodyModel] = [ChatBodyModel]()
    public let chatListSubject : PublishSubject<[ChatBodyModel]> = PublishSubject()
    /// 表情包
    public let emoticonsSubject : PublishSubject<[[EmojiModel]]> = PublishSubject()
    
    public var friendsModel: FriendsModel = FriendsModel()
    
    public override init() {
        super.init()
        
        fetchEmojiData()
    }
}

extension ChatViewModel {
    /// 获取emoji 数据
    func fetchEmojiData() {
        if let emoticonsList = EmojiManager.fetchEmoticonsList {
            emoticonsSubject.onNext(emoticonsList)
        }
    }
}

extension ChatViewModel {
    /// 获取消息列表
    public func fetchChatList(_ parameter: [String : String]) {
        self.loading.onNext(true)
        RPAuthRemoteAPI().requestData(MessageListWithRequest(parameter: parameter as [String : AnyObject]))
            .subscribe(onNext: { returnJson in
                
//                self.receiveChatArray = returnJson["data"]["messages"]["data"].arrayValue.map({ (json) -> ChatBodyModel in
//                    return ChatBodyModel(json: json)
//                })
                
                let chatList = ["故事说，喜鹊在云上架桥；命定之人，会在从桥的那头，奔向你","故事说，喜鹊在云上架桥；命定之人，会在从桥的那头，奔向你","像做梦一样","梦到的故事太长","佳期如梦","遗失的记忆，会以梦的方式重现","就是你吗？","就是此刻","看呐，重逢的指引","看吧！重逢的预示。","啦啦啦啦啦，啦啦啦...啦啦啦...","我在听","在这儿","找到你了","云上一瞬","人间万古","你尽力了","天意如此","你对着月亮许了什么愿？","天上人间，岁岁年年","是你对神灵，许下因果吗？","若前生未果，便重征来世","梦醒之后。","有什么，被忘记了吗？","经历，贯穿命运的强光","这就是，全部的过往。","他们有着，不同于强者的力量","天地之间，无处不是野草般的生命","除了神女，我还有个自己的名字"]
                self.chatListArray = chatList.map { chat -> ChatBodyModel  in
                    var model = ChatBodyModel(json: JSON([:]))
                    model.msg = chat
                    return model
                }
                
                if self.chatListArray.count != 0 {
                    self.chatListSubject.onNext(self.chatListArray)
                } else {
                    self.noMoreData.onNext(NSLocalizedString("No More Data", comment: ""))
                }
            }, onError: { errorJson in
                self.errorSubject.onNext(NSLocalizedString("Unknown Error", comment: ""))
                self.loading.onNext(false)
            }, onCompleted: {
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
}
