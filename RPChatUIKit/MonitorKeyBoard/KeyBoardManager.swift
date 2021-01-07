//
//  KeyBoardManager.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

public class KeyBoardManager {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    /// 单例
    public static let sharedInstance = KeyBoardManager()

    public var keyboardIsVisible: Bool = false
    /// 缓存键盘的高度
    public var keyboardCacheHeight: CGFloat = 0
    public let keyBoardSubject : PublishSubject<CGFloat> = PublishSubject()
    
    private init() {
        monitorKeyBoard()
    }
    
    private func monitorKeyBoard() {
        // 监听键盘弹出通知
        _ = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] noti in
                guard let `self` = self else { return }
                if let aValue = noti.userInfo {
                    let keyboardRect: CGRect = aValue["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                    self.keyboardCacheHeight = keyboardRect.size.height
                    self.keyboardIsVisible = true
                    self.keyBoardSubject.onNext(keyboardRect.size.height)
                }
            }).disposed(by: disposeBag)
        
        // 监听键盘隐藏通知
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] noti in
                guard let `self` = self else { return }
                self.keyboardIsVisible = false
                self.keyBoardSubject.onNext(0)
        }).disposed(by: disposeBag)
    }
}
