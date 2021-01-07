//
//  ChatView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit
import RPChatDataKit

class ChatView: UIView {
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: ChatViewModel
    
    init(frame: CGRect = .zero, viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
