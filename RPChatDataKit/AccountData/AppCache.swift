//
//  AppCache.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class AppCache: NSObject {
    
    var appCache = NSCache<AnyObject, AnyObject>()
    private static var _appCache: AppCache?

    // 单例
    public static func sharedInstance() -> AppCache {
        guard let instance = _appCache else {
            _appCache = AppCache()
            return _appCache!
        }
        return instance
    }
    
    public override init() {
        super.init()
        appCache.delegate = self
        appCache.name = "RPChatCache"
    }
    
    // save cache
    public func saveLoginCacheWith(_ model: SignInModel) {
        appCache.setValue(model.access_token, forKey: "token")
        
    }
    // remove cache
    public func removeSignInCache() {
        appCache.removeAllObjects()
    }
    
    public func fetchCacheToken() {
        appCache.object(forKey: "token" as AnyObject)
    }
}

extension AppCache: NSCacheDelegate {
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        
    }
}
