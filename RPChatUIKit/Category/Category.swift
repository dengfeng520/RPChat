//
//  Category.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/5.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

/// 屏幕宽
public var __screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
/// 屏幕高
 public var __screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
/// 当前设备是否是iPhone X之后的机型
public var isiPhoneX: Bool {
    if #available(iOS 11.0, *) {
        let keyWindow = UIApplication.shared.keyWindow
        let bottomSafeInset = keyWindow?.safeAreaInsets.bottom
        if bottomSafeInset == 34 || bottomSafeInset == 21 {
            return true
        }
    }
    return false
}
/// 当前Window
public var currentWindows: UIWindow? {
    var window: UIWindow? = nil
    if #available(iOS 13.0, *) {
        for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
            if windowScene.activationState == UIScene.ActivationState.foregroundActive {
                window = windowScene.windows.first
                break
            }
        }
        return window
    } else {
        return UIApplication.shared.keyWindow
    }
}
