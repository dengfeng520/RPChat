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
    /// 表示错误状态的Subject
    public let errorSubject : PublishSubject<String> = PublishSubject()
    /// 成功状态Subject
    public let successSubject: PublishSubject<String> = PublishSubject()
    /// show  or dissmiss LoadingView Subject
    public let loading : PublishSubject<Bool> = PublishSubject()
    /// no more
    public let noMoreData : PublishSubject<String> = PublishSubject()
}
