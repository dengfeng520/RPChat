//
//  RPBannerView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/9.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class RPBannerView: UIView {
    
    static var subBannerView: RPSubBannerView?
    
    public static func showBannerWith<T: BannerViewProtocol>(_ r: T) {
        DispatchQueue.main.async {
            let mode = r.mode ?? .perfectionMode
            let addView = r.addView ?? RPBannerView.currentWindows()
            let context = r.context ?? "loading..."
            let isTime = r.isTime ?? 1.5
        }
    }
    
    public static func hidden(animation: Bool) {
        DispatchQueue.main.async { 
            
        }
    }
}

extension RPBannerView {
    public class func currentWindows() -> UIWindow? {
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
}


