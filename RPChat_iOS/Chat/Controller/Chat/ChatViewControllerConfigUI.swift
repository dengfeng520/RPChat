//
//  ChatViewControllerConfigUI.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPBannerView
import RPChatDataKit
import RPChatUIKit

extension ChatViewController {
    func bindViewModel() {
        title = viewModel.friendsModel.userName
        title = "如梦令"
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // fetch chat list
        configChatArrayData()
        // chatList subject
        viewModel.chatListSubject.bind(to: chatListVC.chatListSub).disposed(by: disposeBag)
        // emoji subject
        
        // error
        viewModel.errorSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            RPBannerView.show(with: .perfectionMode, body: error, isView: self.view)
        }).disposed(by: disposeBag)
        
    }
    
    func configChatUI() {
        hiddenBackTitle()
        bindViewModel()
        configSocketManager()
//        monitorKeyBoard()
    }
}

