//
//  Flag.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/29.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

final public class Flag {
    /// - Singletons
    #if TEST
    public static let isFirst = true
    #else
    public static let isFirst = Flag(for: "key.siginInfo.value").wasNotSet
    #endif
    
    /// - Typealias
    public typealias Getter = () -> Bool
    public typealias Setter = (Bool) -> Void
    
    /// - Attributes
    var wasSet: Bool
    public var wasNotSet: Bool {
        return !wasSet
    }
    
    /// - Initializers
    public init(getter: Getter, setter: Setter) {
        self.wasSet = getter()
        
        if !wasSet {
            setter(true)
        }
    }
    
    convenience init(
        userDefaults: UserDefaults = UserDefaults.standard, for key: String) {
        self.init(getter: {
            userDefaults.bool(forKey: key)
        }, setter: {
            userDefaults.set($0, forKey: key)
        })
    }
}
