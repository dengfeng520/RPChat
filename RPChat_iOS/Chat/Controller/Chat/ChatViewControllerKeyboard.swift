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

extension ChatViewController {
    var keyboardheight: Binder<CGFloat> {
        return Binder(self) { [weak self] (chatVC,height) in
            guard let `self` = self else { return }
            if height > 0 {
                self.keyBoardAnimate(height)
            } else {
                self.keyBoardAnimate(0)
            }
        }
    }
    
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
}

extension ChatViewController {
    /// 监听键盘
    func monitorKeyBoard() {
        KeyBoardManager.sharedInstance.keyBoardSubject.bind(to: self.keyboardheight).disposed(by: disposeBag)
        // tableView上下滚动时监听键盘
        tableView.rx.contentOffset.bind(to: self.scrollMode).disposed(by: disposeBag)
    }
    
    /// 键盘动画
    private func keyBoardAnimate(_ height: CGFloat) {
        self.keyboardBottom.constant = -height
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.toolView.superview?.layoutIfNeeded()
        } completion: { (finished) in
            
        }
    }
    
    /// 主动开启键盘
    private func openKeyboard() {
        if KeyBoardManager.sharedInstance.keyboardIsVisible == false {
            self.toolView.inputChatView.becomeFirstResponder()
        }
    }
    
    /// 关闭键盘
    private func closedKeyboard() {
        if KeyBoardManager.sharedInstance.keyboardIsVisible == true {
            self.toolView.inputChatView.resignFirstResponder()
        }
    }
}
