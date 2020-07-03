//
//  LoadingView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/3.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {
    public class func showLoading(_ withView: UIView) {
        DispatchQueue.main.async {
            let loading = MBProgressHUD.showAdded(to: withView, animated: true)
            loading.mode = .indeterminate
            loading.removeFromSuperViewOnHide = true
            loading.label.text = "loading..."
        }
    }
    
    public class func dissmissLoading(_ withView: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: withView, animated: true)
        }
    }
}
