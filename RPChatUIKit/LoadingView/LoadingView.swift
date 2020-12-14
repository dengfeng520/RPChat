//
//  LoadingView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/3.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPToastView

extension RPToastView {
    /// loading
    public class func showLoading(_ withView: UIView?) {
        guard let withView = withView else { return }
        DispatchQueue.main.async {
            var display = Display()
            display.isView = withView
            display.mode = .rotateAndTextMode
            display.title = "Loading..."
            RPToastView.loading(display)
        }
    }
    /// toast
    public class func showToast(_ withView: UIView?, _ labelTxt: String?) {
        guard let withView = withView, let labelTxt = labelTxt else { return }
        DispatchQueue.main.async {
            var display = Display()
            display.isView = withView
            display.mode = .onlyTextMode
            display.title = labelTxt
            RPToastView.loading(display)
        }
    }
    /// dissmiss
    public class func dissmissLoading() {
        DispatchQueue.main.async {
            RPToastView.hidden(animation: true)
        }
    }
}

extension Reactive where Base: UIViewController {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active == true {
                RPToastView.loading(Display(mode: .rotateAndTextMode, isView: vc.view, title: "Loading..."))
            } else {
                RPToastView.hidden(animation: true)
            }
        })
    }
}
