//
//  ChatViewControllerKeyboard.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit
import RPChatDataKit

extension ChatViewController {
    /// keyboard animation
    var keyBoardChangeHeight: Binder<CGFloat> {
        return Binder(self) { [weak self] (chatVC, height) in
            guard let `self` = self else { return }
            self.keyBoardAnimate(height)
        }
    }
    func keyBoardAnimate(_ height: CGFloat) {
        toolBoxHeight.constant = height
        UIView.animate(withDuration: TimeInterval(truncating: KeyBoardManager.sharedInstance.animationDuration)) { [weak self] in
            guard let `self` = self else { return }
            self.toolBoxView.superview?.layoutIfNeeded()
            if height > 0 {
                self.chatListVC.scrollWithBottom()
            }
        } completion: { finished in
            
        }
    }
    // 上下滑动时键盘处理
    var keyboardScroll: Binder<Bool> {
        return Binder(self) { [weak self] (chatVC, show) in
            guard let `self` = self else { return }
            if show == true {
                KeyBoardManager.sharedInstance.fixKeyboardVisible(.show)
                self.toolBoxVC.openKeyboard()
            } else {
                self.toolBoxVC.closedKeyboard()
            }
        }
    }
    // 点击列表时键盘处理
    var tapListViewHandle: Binder<CGFloat> {
        return Binder(self) { [weak self] (chatVC, height) in
            guard let `self` = self else { return }
            KeyBoardManager.sharedInstance.fixKeyboardVisible(.hidden)
            self.toolBoxVC.closedKeyboard()
            self.toolBoxVC.resetStatus()
            self.keyBoardAnimate(height)
        }
    }
}

extension ChatViewController {
    // FIXME: - 多次滑动UITableView会冲突，需要点2次输入框才会弹出键盘
    func keyboardHandle() {
        // 上下滑动时键盘处理
//        chatListVC.openKeyboardSubject.bind(to: keyboardScroll).disposed(by: disposeBag)
        // 点击列表时隐藏键盘
        chatListVC.tapListViewSubject.bind(to: tapListViewHandle).disposed(by: disposeBag)
        // 显示 或 隐藏键盘时
        toolBoxVC.showKeyboardOrEmojiSubject.bind(to: keyBoardChangeHeight).disposed(by: disposeBag)
    }
}
