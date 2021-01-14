//
//  ToolBoxViewController+Keyboard.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/13.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit
import RPChatUIKit

extension ToolBoxViewController {
    /// UITextView获取焦点时键盘处理
    var toolBoxHeight: Binder<CGFloat> {
        return Binder(self) { [weak self] (chatVC, height) in
            guard let `self` = self else { return }
            if height > 0 {
                self.showKeyboardOrEmojiSubject.onNext(height + 55)
            } else {
                if KeyBoardManager.sharedInstance.keyboardIsVisible == .hidden {
                    self.showKeyboardOrEmojiSubject.onNext(55)
                }
            }
        }
    }
    
    /// click the button on the toolbar to handle the keyboard
    var touchTool: Binder<KeyboardVisible> {
        return Binder(self) { [weak self] (chatVC, visible) in
            guard let `self` = self else { return }
            KeyBoardManager.sharedInstance.fixKeyboardVisible(visible)
            self.toolView.inputChatView.resignFirstResponder()
            if visible == .emoji {
                self.openEmojiView()
            } else if visible == .menu {
                self.openMenuView()
            } else if visible == .microphone {
                self.openMicrophoneView()
            }
        }
    }
    /// click the send button on the keyboard
    var keyboardSendTap: Binder<Void> {
        return Binder(self) { [weak self] (chatVC, send) in
            guard let `self` = self, let inputTxt = self.toolView.inputChatView.text else { return }
            self.tapSendMessageSubject.onNext(inputTxt)
        }
    }
}


extension ToolBoxViewController {
    /// 监听键盘
    // FIXME: - 多次滑动UITableView会冲突，需要点2次输入框才会弹出键盘
    func monitorKeyBoard() {
        // 工具栏
        toolView.tapToolBtnSubject.bind(to: touchTool).disposed(by: disposeBag)
        // 键盘将要显示时
        KeyBoardManager.sharedInstance.keyBoardSubject.bind(to: toolBoxHeight).disposed(by: disposeBag)
        // 用户点击发送
        toolView.inputChatView.rx.didChange.bind(to: keyboardSendTap).disposed(by: disposeBag)
    }
}

extension ToolBoxViewController {
    /// 主动开启键盘
    func openKeyboard() {
        if KeyBoardManager.sharedInstance.keyboardIsVisible == .show {
            toolView.inputChatView.becomeFirstResponder()
            resetStatus()
        }
    }
    
    /// 关闭键盘
    func closedKeyboard() {
        if KeyBoardManager.sharedInstance.keyboardIsVisible == .hidden {
            toolView.inputChatView.resignFirstResponder()
        } else {
            KeyBoardManager.sharedInstance.fixKeyboardVisible(.hidden)
        }
    }
    /// 显示emojiView
    func openEmojiView() {
        emojiView.isHidden = false
        menuView.isHidden = true
        microphoneView.isHidden = true
        showKeyboardOrEmojiSubject.onNext(265)
    }
    /// 显示microphone View
    func openMicrophoneView() {
        emojiView.isHidden = true
        menuView.isHidden = true
        microphoneView.isHidden = false
        showKeyboardOrEmojiSubject.onNext(210)
    }
    /// show menu view
    func openMenuView() {
        emojiView.isHidden = true
        menuView.isHidden = false
        microphoneView.isHidden = true
        showKeyboardOrEmojiSubject.onNext(265)
    }
}
