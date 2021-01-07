//
//  UIScrollViewExtension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum scrollDirection {
    // 向上滚动
    case up
    // 向下滚动
    case down
}

extension UIScrollView {
    /// 滚动方向
    public var scrollContent: Observable<scrollDirection> {
        return Observable.create { (observer) -> Disposable in
            self.rx.contentOffset.subscribe(onNext: { content in
                let point = self.panGestureRecognizer.translation(in: self.superview)
                if point.y < -15 {
                    observer.onNext(.up)
                } else {
                    observer.onNext(.down)
                }
            }).disposed(by: DisposeBag())
            return Disposables.create {  }
        }
    }
}
