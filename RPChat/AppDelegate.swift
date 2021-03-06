//
//  AppDelegate.swift
//  RPChat
//
//  Created by rp.wang on 2020/6/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChat_iOS
import RPChatDataKit
import RPKeychain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
            
        } else {
            window = UIWindow()
            window?.frame = UIScreen.main.bounds
            // 如果用户重新下载的
            if Flag.isFirst == true {
                // 进入引导页 并清理keychain中存储的用户信息
                
            } else {
                if let signInInfo = RPKeychain.default.string(forKey: "key.siginInfo.value") {
                    print("signInInfo================\(signInInfo)")
                    let tabbarVC = UITabBarControllerExtension()
                    window?.rootViewController = tabbarVC
                } else {
                    let signInVC = SignInViewController()
                    window?.rootViewController = signInVC
                }
            }
            
            window?.makeKeyAndVisible()
        }
        return true
    }
}

@available(iOS 13.0, *)
extension AppDelegate {
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
