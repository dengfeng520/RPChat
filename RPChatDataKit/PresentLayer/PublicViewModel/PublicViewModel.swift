//
//  PublicViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/8/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import RxSwift
import RxCocoa

public class PublicViewModel: NSObject {
    public let disposeBag = DisposeBag()
        
    public let errorSubject : PublishSubject<String> = PublishSubject()
    public let successSubject: PublishSubject<String> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let noMoreData : PublishSubject<String> = PublishSubject()
}
