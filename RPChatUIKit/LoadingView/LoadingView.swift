//
//  LoadingView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/3.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxSwift
import RxCocoa
import RPToastView

extension MBProgressHUD {
    /// loading
    public class func showLoading(_ withView: UIView?) {
        guard let withView = withView else { return }
        DispatchQueue.main.async {
            let loading = MBProgressHUD.showAdded(to: withView, animated: true)
            loading.mode = .indeterminate
            loading.removeFromSuperViewOnHide = true
            loading.label.text = "loading..."
        }
    }
    /// toast
    public class func showToast(_ withView: UIView?, _ labelTxt: String?) {
        guard let withView = withView, let labelTxt = labelTxt else { return }
        DispatchQueue.main.async {
            let loading = MBProgressHUD.showAdded(to: withView, animated: true)
            loading.mode = .text
            loading.removeFromSuperViewOnHide = true
            loading.label.text = labelTxt
            loading.hide(animated: true, afterDelay: 1.5)
        }
    }
    /// dissmiss
    public class func dissmissLoading(_ withView: UIView?) {
        guard let withView = withView else { return }
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: withView, animated: true)
        }
    }
}

extension Reactive where Base: UIViewController {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active == true {
                RPToastView.loading(Display(mode: .loopAndTextMode, isView: vc.view, title: "Loading..."))
            } else {
                RPToastView.hidden(animation: true)
            }
        })
    }
}
