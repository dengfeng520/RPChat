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
    /// UITextView获取焦点时键盘处理
    var keyboardheight: Binder<CGFloat> {
        return Binder(self) { [weak self] (chatVC, height) in
            guard let `self` = self else { return }
            if height > 0 {
                self.keyBoardAnimate(height)
            } else {
                if KeyBoardManager.sharedInstance.keyboardIsVisible == .hidden {
                    self.keyBoardAnimate(0)
                }
            }
        }
    }
    /// 滚动时键盘处理
    var scrollMode: Binder<CGPoint> {
        return Binder(self) { [weak self] (chatVC, content) in
            guard let `self` = self else { return }
            let point = self.tableView.panGestureRecognizer.translation(in: self.view)
            if point.y < -10 {
                // 向上滚动
                let currentOffset = content.y + self.tableView.bounds.size.height - self.tableView.contentInset.bottom
                // 滚到最底部时显示键盘
                if currentOffset >= self.tableView.contentSize.height {
                    self.openKeyboard()
                }
            } else if point.y > 10 {
                // 向下滚动
                self.closedKeyboard()
            }
        }
    }
    /// 点击工具栏上按钮键盘处理
    var touchTool: Binder<KeyboardVisible> {
        return Binder(self) { [weak self] (chatVC, visible) in
            guard let `self` = self else { return }
            KeyBoardManager.sharedInstance.fixKeyboardVisible(visible)
            self.toolView.inputChatView.resignFirstResponder()
        }
    }
}

extension ChatViewController {
    /// 监听键盘
    func monitorKeyBoard() {
        // tableView上下滚动时键盘处理
        tableView.rx.contentOffset.bind(to: scrollMode).disposed(by: disposeBag)
        // 工具栏
        toolView.tapToolBtnSubject.bind(to: touchTool).disposed(by: disposeBag)
        // 键盘将要显示时
        KeyBoardManager.sharedInstance.keyBoardSubject.bind(to: keyboardheight).disposed(by: disposeBag)
        
    }
    
    /// 键盘动画
    private func keyBoardAnimate(_ height: CGFloat) {
        keyboardBottom.constant = -height
        UIView.animate(withDuration: TimeInterval(truncating: KeyBoardManager.sharedInstance.animationDuration)) { [weak self] in
            guard let `self` = self else { return }
            self.toolView.superview?.layoutIfNeeded()
            self.scrollWithBottom()
        } completion: { finished in
            
        }
    }
}

extension ChatViewController {
    /// 主动开启键盘
    func openKeyboard() {
        toolView.inputChatView.becomeFirstResponder()
    }
    
    /// 关闭键盘
    func closedKeyboard() {
        if KeyBoardManager.sharedInstance.keyboardIsVisible == .hidden {
            toolView.inputChatView.resignFirstResponder()
        } else {
            KeyBoardManager.sharedInstance.fixKeyboardVisible(.hidden)
            keyBoardAnimate(0)
        }
    }
}
