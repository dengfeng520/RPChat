//
//  KeyBoardManager.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

public enum KeyboardVisible {
    case show
    case hidden
    case microphone
    case emoji
    case other
}

public class KeyBoardManager {
    let disposeBag: DisposeBag = DisposeBag()
    /// 单例
    public static let sharedInstance = KeyBoardManager()
    /// 键盘是否显示
    public var keyboardIsVisible: KeyboardVisible = .hidden
    /// 缓存键盘的高度
    public var keyboardCacheHeight: CGFloat = 271
    /// 键盘弹出动画时间
    public var animationDuration: NSNumber = 0.25
    /// 键盘监听
    public let keyBoardSubject : PublishSubject<CGFloat> = PublishSubject()
    
    private init() {
        monitorKeyBoard()
    }
    
    /// 修改键盘显示状态
    public func fixKeyboardVisible(_ withVisible: KeyboardVisible) {
        keyboardIsVisible = withVisible
    }

    /// 通知中心
    private func monitorKeyBoard() {
        // 键盘即将出现
        _ = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] noti in
                guard let `self` = self else { return }
                if let aValue = noti.userInfo {
                    // 获取键盘高度
                    let keyboardRect: CGRect = aValue["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                    self.keyboardCacheHeight = keyboardRect.size.height
                    self.keyboardIsVisible = .show
                    // 获取键盘弹出动画
                    _ = aValue[UIResponder.keyboardAnimationCurveUserInfoKey]
                    // 获取键盘弹出动画时间
                    if let duration = aValue[UIResponder.keyboardAnimationDurationUserInfoKey] {
                        self.animationDuration = duration as! NSNumber
                    }
                    self.keyBoardSubject.onNext(keyboardRect.size.height)
                }
            }).disposed(by: disposeBag)
        // 键盘已经出现
        _ = NotificationCenter.default.rx.notification(UIResponder.keyboardDidShowNotification)
            .subscribe(onNext: { noti in
                
        }).disposed(by: disposeBag)
        // 键盘即将隐藏
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] noti in
                guard let `self` = self else { return }
                if self.keyboardIsVisible == .show {
                    self.keyboardIsVisible = .hidden
                }
                self.keyBoardSubject.onNext(0)
        }).disposed(by: disposeBag)
        // 键盘已经隐藏
        _ = NotificationCenter.default.rx.notification(UIResponder.keyboardDidHideNotification)
            .subscribe(onNext: { noti in
                
        }).disposed(by: disposeBag)
    }
}
