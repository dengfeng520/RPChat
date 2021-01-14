//
//  ChatListViewController+Keyboard.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/13.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit

extension ChatListViewController {
    //// keyboard handling when scrolling
    var scrollMode: Binder<CGPoint> {
        return Binder(self) { [weak self] (chatVC, content) in
            guard let `self` = self else { return }
            let point = self.tableView.panGestureRecognizer.translation(in: self.view)
            if point.y < -20 {
                // 向上滚动
                let currentOffset = content.y + self.tableView.bounds.size.height - self.tableView.contentInset.bottom
                // 滚到最底部时显示键盘
                if currentOffset >= self.tableView.contentSize.height {
                    self.openKeyboardSubject.onNext(true)
                }
            } else if point.y > 20 {
                // 向下滚动
                self.openKeyboardSubject.onNext(false)
            }
        }
    }

    
    func keyboardAbout() {
        // tableView上下滚动时键盘处理
        tableView.rx.contentOffset.bind(to: scrollMode).disposed(by: disposeBag)
        
        // 点击事件
        let touch = UITapGestureRecognizer()
        tableView.addGestureRecognizer(touch)
        touch.cancelsTouchesInView = false
        touch.rx.event.subscribe(onNext: { [weak self] tap in
            guard let `self` = self else { return }
            KeyBoardManager.sharedInstance.fixKeyboardVisible(.touch)
            self.tapListViewSubject.onNext(55)
        }).disposed(by: disposeBag)
    }
}
