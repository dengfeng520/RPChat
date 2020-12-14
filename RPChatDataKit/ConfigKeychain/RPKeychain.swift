//
//  RPKeychain.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Security

public class RPKeychain: NSObject {
    
    static let query = [
        kSecClass: kSecClassInternetPassword,
        kSecAttrServer: "pullipstyle.com",
        kSecReturnAttributes: true,
        kSecReturnData: true
    ] as CFDictionary
    
    public class func fetchUserName() {
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
    }
    
    public class func fetchKeychainQuery(_ server: String) -> [String : String] {
        return [:]
    }
    
    public class func save(_ service: String, _ data: AnyObject) {
        
    }
    
}
