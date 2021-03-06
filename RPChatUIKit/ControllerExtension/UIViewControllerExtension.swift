//
//  UIViewControllerExtension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

extension UIViewController {
    /// 当前windows上显示的最上层UIViewController
    public class func fetchCurrentViewController(baseVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        guard let baseVC = baseVC else {
            return nil
        }
        if let nav = baseVC as? UINavigationController {
            return fetchCurrentViewController(baseVC: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            return fetchCurrentViewController(baseVC: tab.selectedViewController)
        }
        if let presented = baseVC.presentedViewController {
            return fetchCurrentViewController(baseVC: presented)
        }
        return baseVC
    }
    
    public func hiddenBackTitle() {
        view.backgroundColor = .darkModeViewColor
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem?.title = ""
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }
}


extension UIViewController {
    public func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        parentView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    public func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}


