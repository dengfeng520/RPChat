//
//  MessageListViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/9/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import RxSwift

public class MessageListViewModel: PublicViewModel {

    
    public override init() {
        super.init()
        
    }
    
    public func configBOOL() {
        self.loading.onNext(true)
    }
}
