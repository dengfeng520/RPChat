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
        
    public let chatListArray: [ConversatModel] = [ConversatModel]()
    public let chatListSubject : PublishSubject<[ConversatModel]> = PublishSubject()
    
    func fetchChatList() {
        self.loading.onNext(true)
        HTTPRequest().requestWithMap(ChatListWithRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            self.loading.onNext(false)
        }
    }
}
